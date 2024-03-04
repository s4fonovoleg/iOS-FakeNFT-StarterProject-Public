//
//  ProfileNavigationController.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 20.02.2024.
//

import UIKit

final class ProfileNavigationController: UINavigationController {
    
    let servicesAssembly: ServicesAssembly

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileViewModel = ProfileViewModel(servicesAssembly: servicesAssembly)
        self.setViewControllers([ProfileViewController(profileViewModel: profileViewModel)], animated: true)
    }
}
