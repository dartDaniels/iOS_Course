//
//  SecondStateViewController.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 21.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

class SecondStateViewController: UIViewController {
    let heroModel = HeroModel()
    
        override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = .black
                setupSubviews()
            }
        
        func configure(heroImage: String, heroName: String, heroDesc: String) {
            print("Configuring SecondStateViewController with name: \(heroName)")
            if let url = URL(string: heroImage) {
                self.heroView.image = nil
                self.heroView.kf.indicatorType = .activity
                if let indicator = heroView.kf.indicator as? UIActivityIndicatorView {
                    indicator.startAnimating()
                }
                self.heroView.kf.setImage(with: url)
            }
            heroLabel.text = heroName
            heroDescription.text = heroDesc
        }

        
        private let heroView: UIImageView = {
            let view = UIImageView()
            view.clipsToBounds = true
            return view
        }()
        
        private let heroLabel: UILabel = {
            let name = UILabel()
            name.font = UIFont.systemFont(ofSize: .init(34), weight: .bold)
            name.textColor = .white
            return name
        }()
        
        private let heroDescription: UILabel = {
            let description = UILabel()
            description.font = UIFont.systemFont(ofSize: .init(22), weight: .bold)
            description.textColor = .white
            description.numberOfLines = 0
            return description
        }()
        
        private let backButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "backButton"), for: .normal)
            button.tintColor = .gray
            button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
            return button
        }()
        
        private func setupSubviews() {
            view.addSubview(heroView)
            heroView.snp.makeConstraints { make in
                make.size.equalToSuperview()
            }
            view.addSubview(heroLabel)
            heroLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(700)
                make.leading.equalToSuperview().inset(30)
            }
            view.addSubview(heroDescription)
            heroDescription.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(750)
                make.leading.equalToSuperview().inset(30)
            }
            view.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50)
                make.leading.equalToSuperview().inset(16)
                make.height.equalTo(32)
                make.width.equalTo(28)
            }
        }
        
        @objc func dismissPressed() {
            dismiss(animated: true, completion: nil)
        }

}
