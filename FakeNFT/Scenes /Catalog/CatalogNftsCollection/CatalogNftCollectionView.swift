//
//  CatalogNftCollectionView.swift
//  FakeNFT
//
//  Created by Георгий Ксенодохов on 20.02.2024.
//

import UIKit
import SnapKit
import ProgressHUD

final class CatalogNftCollectionView: UIViewController {

    private var service = CatalogNftService()

    var id: String?

    private var scrollView = UIScrollView()

    private var imageView: UIImageView = {
        var image = UIImageView()
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()

    private var nameOfNFTCollectionLabel: UILabel = {
        var label = UILabel()
        label.font = .headline3
        label.textColor = UIColor(named: "BlackColor")
        return label
    }()

    private var nameOfAuthor: UILabel = {
        var label = UILabel()
        label.font = .caption2
        label.textColor = UIColor(named: "BlackColor")
        return label
    }()

    private var nftDescription: UILabel = {
        var label = UILabel()
        label.font = .caption2
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.textColor = UIColor(named: "BlackColor")
        return label
    }()

    private var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collection.backgroundColor = UIColor(named: "White")
        collection.contentInset = UIEdgeInsets(top: 6, left: 16, bottom: 24, right: 16)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        setupScreen()
        service.loadNftColletion(compleition: { result in
            switch result {
            case .success(let res):
                self.imageView.kf.setImage(with: URL(string: res.cover))
                self.nameOfNFTCollectionLabel.text = res.name
                self.nameOfAuthor.text = "Автор коллекции: " + res.author
                self.nftDescription.text = res.description
            case .failure(_):
                print("lol")
            }}, id: id!)
    }

    private func setupScreen() {
        view.addSubview(scrollView)
        scrollView.contentInsetAdjustmentBehavior = .never
        [imageView,
        nameOfNFTCollectionLabel,
        nameOfAuthor,
         nftDescription,
        collectionView].forEach {
            self.scrollView.addSubview($0)
        }
        scrollView.snp.makeConstraints {
            $0.left.bottom.right.top.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(310)
            $0.width.equalToSuperview()
        }
        nameOfNFTCollectionLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp_bottomMargin).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalToSuperview().offset(-32)
        }
        nameOfAuthor.snp.makeConstraints {
            $0.top.equalTo(nameOfNFTCollectionLabel.snp_bottomMargin).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalToSuperview().offset(-32)
        }
        nftDescription.snp.makeConstraints {
            $0.top.equalTo(nameOfAuthor.snp_bottomMargin).offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalToSuperview().offset(-32)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(nftDescription.snp_bottomMargin).offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalToSuperview().offset(-32)
            $0.bottom.greaterThanOrEqualToSuperview()
        }
        view.backgroundColor = UIColor(named: "WhiteColor")
    }
}
