//
//  SecondStateViewController.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 21.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

class HeroCardViewController: UIViewController {
    private var viewModel = HeroViewModel()
    private var heroIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchHeroDetails()
    }
    
    func configure(with viewModel: HeroViewModel, at index: Int) {
            self.viewModel = viewModel
            self.heroIndex = index
            
            let hero = viewModel.getHero(at: index)
            heroLabel.text = hero.name
            
            if let fullImageURL = hero.thumbnail.fullURL, let url = URL(string: fullImageURL) {
                heroView.kf.setImage(with: url, placeholder: Images.heroPlaceholder)
            } else {
                heroView.image = Images.heroPlaceholder
            }
        }
    
    private func fetchHeroDetails() {
        let hero = viewModel.getHero(at: heroIndex)
        
        let characterId = hero.id
        
        if characterId == 0 {
            heroDescription.text = "Описание недоступно"
            return
        }
        
        viewModel.fetchHeroDescription(characterId: characterId)
        
        viewModel.onHeroDescriptionLoaded = { [weak self] description in
            DispatchQueue.main.async {
                self?.heroDescription.text = description ?? "Описание недоступно"
            }
        }
    }
    
    private let heroView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    private let heroLabel: UILabel = {
        let name = UILabel()
        name.font = Fonts.heroNameFont
        name.textColor = .white
        return name
    }()
    
    private let heroDescription: UILabel = {
        let description = UILabel()
        description.font = Fonts.heroDescriptionFont
        description.textColor = .white
        description.numberOfLines = 0
        description.lineBreakMode = .byWordWrapping
        return description
    }()
    
    private func setupViews() {
        view.addSubview(heroView)
        heroView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        view.addSubview(heroLabel)
        heroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenSize.screenHeight/1.25)
            make.leading.equalToSuperview().inset(screenSize.screenWidth/13)
        }
        view.addSubview(heroDescription)
        heroDescription.snp.makeConstraints { make in
            make.top.equalTo(heroLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(screenSize.screenWidth/13)
        }
    }
    
    @objc func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }

}
