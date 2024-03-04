//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 27.02.2024.
//

import Foundation
import Combine

final class ProfileViewModel {
    
    @Published var avatar: String?
    @Published var description: String?
    @Published var name: String?
    @Published var website: String?
    @Published var favoriteNFTs: [String]?
    @Published var myNFTs: [String]?
    
    private let servicesAssembly: ServicesAssembly
    
    var profile: Profile? {
        didSet {
            avatar = profile?.avatar
            description = profile?.description
            favoriteNFTs = profile?.likes
            myNFTs = profile?.nfts
            name = profile?.name
            website = profile?.website
        }
    }
    
    var alertInfo: (( _ title: String, _ buttonTapped: String, _ message: String) -> Void)?
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        
        loadInitData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadInitData(){
        
        servicesAssembly.profileService.loadProfile { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                // TODO: Локализовать уведомления в следующей итерации
                
                self.profile = profile
            case .failure( _ ):
                self.alertInfo?("Ой-ой-ой ...", "Очень жаль", "Не удалось загрузить данные профиля")
            }
        }
    }
    
    func genEditViewModel() -> ProfileEditViewModel? {
        
        guard let profile = profile else { return nil }
        return ProfileEditViewModel(servicesAssembly: servicesAssembly, parentViewModel: self, with: profile)
    }
}
