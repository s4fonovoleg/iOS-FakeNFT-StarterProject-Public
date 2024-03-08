//
//  File.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 05.03.2024.
//

import UIKit
import ProgressHUD

final class ProfileMyNFTsViewModel {
    
    @Published var myNFTs: [Nft]?
    
    private let servicesAssembly: ServicesAssembly
    
    var alertInfo: (( _ title: String, _ buttonTitle: String, _ message: String) -> Void)?
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func getNFTs(by idList: [String]?){
        
        var nftList: [Nft] = [Nft]()
        var gotError: Int = 0
        
        let gettingNFTs: DispatchGroup = DispatchGroup()
        
        ProgressHUD.show()
        
        idList?.forEach({ id in
            
            gettingNFTs.enter()
            
            servicesAssembly.nftService.loadNft(id: id) { result in
                
                switch result {
                case .success(let nft):
                    
                    nftList.append(nft)
                    gettingNFTs.leave()
                    
                case .failure(_):
                    
                    gotError += 1
                    gettingNFTs.leave()
                }
            }
        })
        
        gettingNFTs.notify(queue: .main) {
            
            self.myNFTs = nftList
            
            if gotError == idList?.count {
                self.alertInfo?(NSLocalizedString(LocalizableKeys.profileMyNFTsLoadErrorTitle, comment: ""),
                                NSLocalizedString(LocalizableKeys.profileMyNFTsLoadErrorButton, comment: ""),
                                NSLocalizedString(LocalizableKeys.profileMyNFTsLoadErrorAll, comment: ""))
            } else if gotError > 0 {
                self.alertInfo?(NSLocalizedString(LocalizableKeys.profileMyNFTsLoadErrorTitle, comment: ""),
                                NSLocalizedString(LocalizableKeys.profileMyNFTsLoadErrorButton, comment: ""),
                                NSLocalizedString(LocalizableKeys.profileMyNFTsLoadErrorSome, comment: ""))
            }
            
            ProgressHUD.dismiss()
        }
    }
}
