//
//  CatalogCollectionCell.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 21.02.2024.
//

import UIKit
import Kingfisher
import SnapKit

final class CatalogCollectionCell: UICollectionViewCell {

    static let catalofNftId = "catalofNftId"

    weak var delegate: CatalogCollectionCellDelegate?

    private let nftImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()

    private lazy var addTofavorite: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "LikeOff"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(tapOnLike), for: .touchUpInside)
        return button
    }()

    private let addToCart: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "CartOff"), for: .normal)
        button.tintColor = .red
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    private let ratingImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()

    private let nameOfNftLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyBold
        return label
    }()

    private let priceLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    func config(_ nft: Nft) {
        setupScreen()
        nftImage.kf.setImage(with: URL(string: nft.images.first!))
        nameOfNftLabel.text = nft.name 
        priceLabel.text = "\(nft.price)" + " ETH"
        switch nft.rating {
        case 0:
            ratingImage.image = UIImage(named: "ZeroStars")
        case 1:
            ratingImage.image = UIImage(named: "OneStars")
        case 2:
            ratingImage.image = UIImage(named: "TwoStars")
        case 3:
            ratingImage.image = UIImage(named: "ThreeStars")
        case 4:
            ratingImage.image = UIImage(named: "FourStars")
        case 5...:
            ratingImage.image = UIImage(named: "FiveStars")
        default:
            break
        }
    }

    private func setupScreen() {
        contentView.addSubview(nftImage)
        contentView.addSubview(ratingImage)
        contentView.addSubview(nameOfNftLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addTofavorite)
        contentView.addSubview(addToCart)

        nftImage.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.width.equalTo(108)
        }
        ratingImage.snp.makeConstraints {
            $0.top.equalTo(nftImage.snp_bottomMargin).offset(15)
            $0.left.equalToSuperview()
            $0.width.equalTo(70)
        }
        nameOfNftLabel.snp.makeConstraints {
            $0.top.equalTo(nftImage.snp_bottomMargin).offset(25)
            $0.left.equalToSuperview()
            $0.width.equalTo(88)
        }
        priceLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(nameOfNftLabel.snp_bottomMargin).offset(10)
        }
        addTofavorite.snp.makeConstraints {
            $0.width.height.equalTo(42)
            $0.right.top.equalToSuperview()
        }
        addToCart.snp.makeConstraints {
            $0.width.height.equalTo(42)
            $0.right.bottom.equalToSuperview()
        }
        backgroundColor = UIColor(named: "WhiteColor")
    }
    @objc private func tapOnLike() {
        delegate?.tapOnLike()
    }

    @objc private func tapOnCart() {
        delegate?.tapOnCart()
    }
}
