//
//  ProfileTableViewCell.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 24.02.2024.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ProfileTableCell"
    
    let myAccessoryView: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(named: ColorNames.black)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = ProfileTableViewCell.reuseIdentifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = myAccessoryView
        textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
