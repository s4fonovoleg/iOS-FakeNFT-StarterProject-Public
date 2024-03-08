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
            name = profile?.name
            website = profile?.website
            favoriteNFTs = profile?.likes
            
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
            myNFTs = mockNFTsList
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
    
    func genMyNFTsViewModel() -> ProfileMyNFTsViewModel {
        
        return ProfileMyNFTsViewModel(servicesAssembly: servicesAssembly)
    }
}
