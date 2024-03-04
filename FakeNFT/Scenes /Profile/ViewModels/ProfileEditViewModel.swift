//
//  ProfileEditViewModel.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 01.03.2024.
//

import Foundation
import Combine

final class ProfileEditViewModel {
    
    @Published var avatar: String?
    @Published var description: String?
    @Published var favoriteNFTs: [String]?
    @Published var name: String?
    @Published var website: String?
    
    private let servicesAssembly: ServicesAssembly
    private weak var parentViewModel: ProfileViewModel?
    
    private var profile: Profile? {
        didSet {
            avatar = profile?.avatar
            description = profile?.description
            favoriteNFTs = profile?.likes
            name = profile?.name
            website = profile?.website
            
            newAvatar = avatar
            newDescription = description
            newFavoriteNFTs = favoriteNFTs
            newName = name
            newWebsite = website
        }
    }
    
    var newAvatar: String?
    var newDescription: String?
    var newFavoriteNFTs: [String]?
    var newName: String?
    var newWebsite: String?
    
    var alertInfo: (( _ title: String, _ buttonTitle: String, _ message: String, _ shouldDismiss: Bool) -> Void)?
    
    init(servicesAssembly: ServicesAssembly, parentViewModel: ProfileViewModel, with profile: Profile) {
        self.servicesAssembly = servicesAssembly
        self.parentViewModel = parentViewModel
        
        self.setProfile(with: profile)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProfile(with originProfile: Profile) {
        
        self.profile = originProfile
    }
    
    func saveProfile(){
        
        var newProfileData: [(String, String)] = [(String,String)]()
        
        newProfileData.append(("avatar", newAvatar ?? ""))
        newProfileData.append(("description", newDescription ?? ""))
        newProfileData.append(("name", newName ?? ""))
        newProfileData.append(("website", newWebsite ?? ""))
        if let favorites = newFavoriteNFTs, favorites.count  > 0 {
            favorites.forEach({
                newProfileData.append(("likes", $0))
            })
        }
        
        let profileData = Urlencoding.urlEncoded(formDataSet: newProfileData)
        
        servicesAssembly.profileService.saveProfile(profileData){ [weak self] result in
            
            guard let self = self else { return }
            
            switch result{
            case .success(let profile):
                self.parentViewModel?.profile = profile
                
               // TODO: Локализовать уведомления в следующей итерации
                self.alertInfo?("Готово", "Отлично!", "Изменения внесены в профиль", true)
            case .failure( _ ):
                self.alertInfo?("Ой-ой-ой ...", "Жаль", "Не удалось обновить данные профиля", false)
            }
        }
    }
}
