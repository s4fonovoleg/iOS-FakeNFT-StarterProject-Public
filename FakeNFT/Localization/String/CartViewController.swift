//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Руслан Халилулин on 11.02.2024.
//

import UIKit

class CartViewController: UIViewController {
  // MARK: - Private properties:
  
  // MARK: - Properties
  
  // MARK: - Private Methods:
  private func navBarSetup() {
    if (navigationController?.navigationBar) != nil {
      let rightButton = UIBarButtonItem(image: UIImage(named: "sortIcon"), style: .plain, target: self, action: #selector(sortButtonTapped))
      navigationItem.rightBarButtonItem = rightButton
    }
  }
  
}

// MARK: - LifeCycle:
extension CartViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navBarSetup()
  }
}

// MARK: - IBActions:
extension CartViewController {
  @objc
  private func sortButtonTapped() {
    
  }
}
