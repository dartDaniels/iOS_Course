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
    
    let viewModel = HeroViewModel()

    func configurate(with heroes: [HeroModel], at index: Int) {
        let hero = heroes[index]
        heroName.text = hero.name
        
        if let fullImageURL = hero.thumbnail?.fullURL, let url = URL(string: fullImageURL) {
            imageView.kf.setImage(with: url, placeholder: Images.heroPlaceholder)
        } else {
            imageView.image = Images.heroPlaceholder
        }
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
            make.size.equalTo(CGSize(width: screenSize.screenBoundsSize.width/3, height: screenSize.screenBoundsSize.height/1.5))
            make.leading.trailing.equalToSuperview().inset(screenSize.screenWidth/8.667)
        }
        imageView.addSubview(heroName)
        heroName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenSize.screenHeight/1.75)
            make.leading.equalToSuperview().inset(screenSize.screenWidth/13)
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
        name.font = Fonts.largeTitle
        name.textColor = .white
        name.isHidden = false
        return name
    }()
}
