//
//  ProfileMyNFTsTableViewCell.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 06.03.2024.
//

import UIKit
import Kingfisher

final class ProfileMyNFTsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MyNFTsTableViewCell"
    
    private lazy var imageViewNFT: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = UIColor(named: ColorNames.lightGray)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var imageViewFavorite: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.favoriteNoActive)
        return imageView
    }()
    
    private lazy var labelAuthor: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var labelFrom: UILabel = {
        let label: UILabel = UILabel()
        label.text = NSLocalizedString(LocalizableKeys.profileMyNFTsfrom, comment: "")
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var labelName: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var labelPrice: UILabel = {
        let label: UILabel = UILabel()
        label.text = NSLocalizedString(LocalizableKeys.profileMyNFTsLabelPrice, comment: "")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var labelPriceValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var stackNFT: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stackNFTLeft: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stackNFTRight: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stackRating: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    private lazy var viewAuthor: UIView = {
        let view: UIView = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var viewNFTContent: UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        for view in stackRating.arrangedSubviews {
            stackRating.removeArrangedSubview(view)
        }
    }
    
    private func setupUI(){
        self.accessoryType = .none
        
        [imageViewNFT, imageViewFavorite, stackNFT,
         stackNFTLeft, labelName, stackRating, viewAuthor, labelFrom, labelAuthor,
         stackNFTRight, labelPrice, labelPriceValue, viewNFTContent].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(viewNFTContent)
        
        viewNFTContent.addSubview(imageViewNFT)
        viewNFTContent.addSubview(imageViewFavorite)
        viewNFTContent.addSubview(stackNFT)
        
        stackNFT.addArrangedSubview(stackNFTLeft)
        stackNFT.addArrangedSubview(stackNFTRight)
        
        stackNFTLeft.addArrangedSubview(labelName)
        stackNFTLeft.addArrangedSubview(stackRating)
        stackNFTLeft.addArrangedSubview(viewAuthor)
        
        viewAuthor.addSubview(labelFrom)
        viewAuthor.addSubview(labelAuthor)
        
        stackNFTRight.addArrangedSubview(labelPrice)
        stackNFTRight.addArrangedSubview(labelPriceValue)
    }
    
    private func setupUILayout(){
        NSLayoutConstraint.activate([
            viewNFTContent.heightAnchor.constraint(equalToConstant: 108),
            viewNFTContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            viewNFTContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            viewNFTContent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageViewNFT.heightAnchor.constraint(equalToConstant: 108),
            imageViewNFT.widthAnchor.constraint(equalToConstant: 108),
            imageViewNFT.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor),
            imageViewNFT.centerYAnchor.constraint(equalTo: viewNFTContent.centerYAnchor),
            
            imageViewFavorite.heightAnchor.constraint(equalToConstant: 40),
            imageViewFavorite.widthAnchor.constraint(equalToConstant: 40),
            imageViewFavorite.topAnchor.constraint(equalTo: viewNFTContent.topAnchor, constant: 0),
            imageViewFavorite.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor, constant: 68),
            
            stackNFTLeft.heightAnchor.constraint(equalToConstant: 62),
            stackNFTLeft.widthAnchor.constraint(equalToConstant: 95),
            stackNFTRight.heightAnchor.constraint(equalToConstant: 42),
            stackNFTRight.widthAnchor.constraint(equalToConstant: 90),
            
            stackNFT.topAnchor.constraint(equalTo: viewNFTContent.topAnchor, constant: 23),
            stackNFT.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor, constant: 128),
            stackNFT.trailingAnchor.constraint(equalTo: viewNFTContent.trailingAnchor, constant: 0),
            stackNFT.bottomAnchor.constraint(equalTo: viewNFTContent.bottomAnchor, constant: -23),
            
            stackRating.heightAnchor.constraint(equalToConstant: 12),
            stackRating.widthAnchor.constraint(equalToConstant: 68),
            
            viewAuthor.heightAnchor.constraint(equalToConstant: 20),
            viewAuthor.widthAnchor.constraint(equalToConstant: 78),
            
            labelFrom.leadingAnchor.constraint(equalTo: viewAuthor.leadingAnchor),
            labelFrom.centerYAnchor.constraint(equalTo: viewAuthor.centerYAnchor),
            
            labelAuthor.leadingAnchor.constraint(equalTo: labelFrom.trailingAnchor, constant: 5),
            labelAuthor.centerYAnchor.constraint(equalTo: viewAuthor.centerYAnchor),
        ])
    }
    
    func setup(with nft: Nft){
        labelName.text = nft.name
        labelAuthor.text = nft.author
        labelPriceValue.text = nft.price.description + " ETH"
        
        if let url = nft.images.first, let imageUrl = URL(string: url) {
            
            self.imageViewNFT.kf.indicatorType = .activity
            self.imageViewNFT.kf.setImage(with: imageUrl)
        }
        
        for i in 0...4 {
            
            let imageName = nft.rating > i ? ImageNames.starActive : ImageNames.starNoActive
            
            let imageView = UIImageView(image: UIImage(named: imageName))
            stackRating.addArrangedSubview(imageView)
        }
    }
}
