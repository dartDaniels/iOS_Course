//
//  CustomCollectionViewCell.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 11.11.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout

class HeroCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    func configurate(image: UIImage, heroName: String) {
        self.imageView.image = image
        self.heroName.text = heroName
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 550))
            make.leading.trailing.equalToSuperview().inset(45)
        }
        imageView.addSubview(heroName)
        heroName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(475)
            make.leading.equalToSuperview().inset(30)
        }
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let heroName: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: .init(32), weight: .bold)
        name.textColor = .white
        name.isHidden = false
        return name
    }()
    
}

extension HeroCollectionViewCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        ScaleTransformViewOptions(minScale: 0.6,
                                  scaleRatio: 0.4,
                                  translationRatio: CGPoint(x: 0.66, y: 0.2),
                                  maxTranslationRatio: CGPoint(x: 2, y: 0)
        )
    }
}
