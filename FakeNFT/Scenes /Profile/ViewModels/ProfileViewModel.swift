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
    
    @Published var profile = CurrentValueSubject<Profile?, Never>(nil)
    
    private let servicesAssembly: ServicesAssembly
    private var subscriptions = Set<AnyCancellable>()
    
    var alertInfo: (( _ title: String, _ buttonTapped: String, _ message: String) -> Void)?
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        
        setupBindings()
        loadInitData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadInitData(){
        
        servicesAssembly.profileService.loadProfile { [weak self] result in
            
            guard let self else { return }
            
            switch result {
            case .success(let profile):
                self.profile.send(profile)
            case .failure( _ ):
                // TODO: Локализовать уведомления в следующей итерации
                self.alertInfo?("Ой-ой-ой ...", "Очень жаль", "Не удалось загрузить данные профиля")
            }
        }
    }
    
    private func setupBindings(){
        
        profile.sink { [weak self] profile in
            
            guard let self else { return }
            self.avatar = profile?.avatar
            self.description = profile?.description
            self.name = profile?.name
            self.website = profile?.website
            self.favoriteNFTs = profile?.likes
            
            // FIXME: Используем мокковые данные пока в профиле отсутствуют реальные
            //            myNFTs = profile?.nfts
            let mockNFTsList = [
                "d6a02bd1-1255-46cd-815b-656174c1d9c0",
                "b2f44171-7dcd-46d7-a6d3-e2109aacf520",
                "594aaf01-5962-4ab7-a6b5-470ea37beb93",
                "9e472edf-ed51-4901-8cfc-8eb3f617519f",
                "a4edeccd-ad7c-4c7f-b09e-6edec02a812b",
                "2c9d09f6-25ac-4d6f-8d6a-175c4de2b42f"
            ]
            self.myNFTs = mockNFTsList
        }.store(in: &subscriptions)
    }
    
    func genEditViewModel() -> ProfileEditViewModel? {
        return ProfileEditViewModel(servicesAssembly: servicesAssembly, profile: profile)
    }
    
    func genMyNFTsViewModel() -> ProfileMyNFTsViewModel {
        return ProfileMyNFTsViewModel(servicesAssembly: servicesAssembly)
    }
    
    func getFavoriteNFTsViewModel() -> ProfileFavoriteNFTsViewModel {
        return ProfileFavoriteNFTsViewModel(servicesAssembly: servicesAssembly, profile: profile)
    }
}
