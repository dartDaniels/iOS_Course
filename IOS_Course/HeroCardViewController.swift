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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func configure(with viewModel: HeroViewModel, at index: Int) {
        let hero = viewModel.getHero(at: index)
                
        viewModel.ImageLoader(from: hero.heroURL, for: heroView, placeholder: Images.heroPlaceholder) { [weak self] image in
            DispatchQueue.main.async {
                self?.heroView.image = image
                self?.heroLabel.text = hero.heroName
                self?.heroDescription.text = hero.heroDescription
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
        return description
    }()
    
    private func setupViews() {
        view.addSubview(heroView)
        heroView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        view.addSubview(heroLabel)
        heroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenSize.screenHeight/1.2)
            make.leading.equalToSuperview().inset(screenSize.screenWidth/13)
        }
        view.addSubview(heroDescription)
        heroDescription.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenSize.screenHeight/1.125)
            make.leading.equalToSuperview().inset(screenSize.screenWidth/13)
        }
    }
    
    @objc func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }

}
