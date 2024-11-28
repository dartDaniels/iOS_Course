//
//  CustomCollectionViewCell.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 11.11.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout
import Kingfisher

class HeroCollectionViewCell: UICollectionViewCell {
    static let identifier = "HeroCollectionViewCell"
    
    let heroModel = HeroModel()

    func configurate(image: String, heroName: String) {
        if let url = URL(string: image) {
            self.imageView.image = nil
            self.imageView.kf.indicatorType = .activity
            if let indicator = imageView.kf.indicator as? UIActivityIndicatorView {
                indicator.startAnimating()
            }
            self.imageView.kf.setImage(with: url)
        }
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
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.isHidden = false
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

extension HeroCollectionViewCell: Placeholder {}
