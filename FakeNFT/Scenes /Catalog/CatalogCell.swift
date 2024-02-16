//
//  TestCatalogCell.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 13.02.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class CatalogCell : UITableViewCell {
    
    private let nftImageView : UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 12
        return image
    }()
    
    private let nftLable : UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .bodyBold
        return label
    }()
    
    
    func config(nft : CatalogCollection){
        setupScreen()
        nftLable.text = "\(nft.name.first!.uppercased())" +
        nft.name.suffix(nft.name.count - 1) +
        " (\(nft.nfts.count))"
        nftImageView.kf.setImage(with: URL(string: nft.cover))
    }
    
    private func setupScreen(){
        contentView.addSubview(nftImageView)
        contentView.addSubview(nftLable)
        
        nftImageView.snp.makeConstraints {
            $0.height.equalTo(140)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        nftLable.snp.makeConstraints {
            $0.left.equalTo(nftImageView)
            $0.top.equalTo(nftImageView.snp_bottomMargin).offset(12)
            $0.bottom.equalToSuperview()
            $0.right.equalTo(nftImageView)
        }
    }
}



