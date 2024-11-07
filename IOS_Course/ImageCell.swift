//
//  ImageCell.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 23.10.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout

class ImageCell: UICollectionViewCell {
    func configurate(image: UIImage, name: String) {
        imageView.image = image
        heroName.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        heroName.text = nil

    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 550))
        }
        contentView.addSubview(heroName)
        heroName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(475)
            make.leading.equalToSuperview().inset(30)
        }
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let heroName: UILabel = {
        let heroName = UILabel()
        heroName.font = UIFont.systemFont(ofSize: .init(32), weight: .bold)
        heroName.textColor = .white
        return heroName
    }()
    
}

extension ImageCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        ScaleTransformViewOptions(minScale: 0.6,
                                  scaleRatio: 0.4,
                                  translationRatio: CGPoint(x: 0.66, y: 0.2),
                                  maxTranslationRatio: CGPoint(x: 2, y: 0)
        )
    }
}





