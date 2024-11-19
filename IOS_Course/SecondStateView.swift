//
//  SecondStateView.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 20.11.2024.
//

import UIKit
import SnapKit

class SecondStateView: UIView {
    let heroNames: [String] = ["Deadpool", "Iron Man", "Spider-Man"]
    let heroDescriptions = ["Please don’t make the super suit green...or animated!",
                            "I AM IRON MAN",
                            "In iron suit"]
    var HeroImages: [UIImage] = [UIImage(named: "HeroOne") ?? UIImage(),
                                  UIImage(named: "HeroTwo") ?? UIImage(),
                                  UIImage(named: "HeroThree") ?? UIImage()
                                  ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(heroImage: UIImage, heroName: String, heroDesc: String, onClose: @escaping ()->Void) {
        heroView.image = heroImage
        heroLabel.text = heroName
        heroDescription.text = heroDesc
        self.onClose = onClose
        backButton.addAction(UIAction { _ in onClose() }, for: .touchUpInside)
    }
    private var onClose: (() -> Void)?

    @objc private func closeButtonTapped() {
            onClose?()
        }
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let heroView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private let heroLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: .init(32), weight: .bold)
        name.textColor = .white
        return name
    }()
    
    private let heroDescription: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: .init(32), weight: .bold)
        description.textColor = .white
        return description
    }()
    
    private func setupViews() {
        addSubview(heroView)
        heroView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(45)
        }
        addSubview(heroLabel)
        heroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(475)
            make.leading.equalToSuperview().inset(30)
        }
        addSubview(heroDescription)
        heroDescription.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(700)
            make.leading.equalToSuperview().inset(150)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().inset(20)
        }
        backButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

    }
    
}
