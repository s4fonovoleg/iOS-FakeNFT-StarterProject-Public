//
//  ProfileFaviriteNFTsViewCell.swift
//  FakeNFT
//
//  Created by Eugene Dmitrichenko on 13.03.2024.
//

import UIKit

class ProfileFavoriteNFTsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "FavoriteNFTCollectionViewCell"
    
    private var nftId: String?
    private weak var delegate: UnlikerProtocol?
    
    private lazy var buttonFavorite: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: ImageNames.favoriteActive), for: .normal)
        return button
    }()
    
    private lazy var imageViewNFT: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = UIColor(named: ColorNames.lightGray)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var labelName: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var labelPriceValue: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var stackNFT: UIStackView = {
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
    
    private lazy var viewNFTContent: UIView = UIView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
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
        [imageViewNFT, buttonFavorite,
         stackNFT, labelName, stackRating,
         labelPriceValue, viewNFTContent].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(viewNFTContent)
        
        viewNFTContent.addSubview(imageViewNFT)
        viewNFTContent.addSubview(buttonFavorite)
        viewNFTContent.addSubview(stackNFT)
        
        stackNFT.addArrangedSubview(labelName)
        stackNFT.addArrangedSubview(stackRating)
        stackNFT.addArrangedSubview(labelPriceValue)
        
        buttonFavorite.addTarget(self, action: #selector(buttonUnlikeTapped), for: .touchUpInside)
    }
    
    private func setupUILayout(){
        NSLayoutConstraint.activate([
            viewNFTContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewNFTContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewNFTContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewNFTContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageViewNFT.heightAnchor.constraint(equalToConstant: 80),
            imageViewNFT.widthAnchor.constraint(equalToConstant: 80),
            imageViewNFT.topAnchor.constraint(equalTo: viewNFTContent.topAnchor),
            imageViewNFT.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor),
            
            buttonFavorite.heightAnchor.constraint(equalToConstant: 30),
            buttonFavorite.widthAnchor.constraint(equalToConstant: 30),
            buttonFavorite.topAnchor.constraint(equalTo: viewNFTContent.topAnchor, constant: 0),
            buttonFavorite.leadingAnchor.constraint(equalTo: viewNFTContent.leadingAnchor, constant: 50),
            
            stackNFT.heightAnchor.constraint(equalToConstant: 66),
            
            stackNFT.leadingAnchor.constraint(equalTo: imageViewNFT.trailingAnchor, constant: 8),
            stackNFT.trailingAnchor.constraint(equalTo: viewNFTContent.trailingAnchor),
            stackNFT.centerYAnchor.constraint(equalTo: viewNFTContent.centerYAnchor),
            
            stackRating.heightAnchor.constraint(equalToConstant: 12),
            stackRating.widthAnchor.constraint(equalToConstant: 68),
        ])
    }
    
    @objc
    private func buttonUnlikeTapped(){
        if let nftId {
            delegate?.unlikeNFT(with: nftId)
        }
    }
    
    func setup(with nft: Nft, delegateTo: UnlikerProtocol){
        delegate = delegateTo
        nftId = nft.id
        
        labelName.text = nft.name
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
