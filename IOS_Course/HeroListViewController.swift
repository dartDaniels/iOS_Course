//
//  ViewController.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 01.10.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout


class HeroListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack
        makeCollectionView()
        setupView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    var cellImages: [UIImage] = [UIImage(named: "HeroOne") ?? UIImage(),
                                  UIImage(named: "HeroTwo") ?? UIImage(),
                                  UIImage(named: "HeroThree") ?? UIImage()
                                  ]
    
    let heroNames: [String] = ["Deadpool", "Iron Man", "Spider-Man"]
    
    let heroDescriptions = ["Please don’t make the super suit green...or animated!",
                            "I AM IRON MAN",
                            "In iron suit"]
    let triangleView = TriangleView()
    
    private var secondStateView: SecondStateView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Нажата карточка героя: \(heroNames[indexPath.item])")
        showHeroDetail(image: cellImages[indexPath.item], name: heroNames[indexPath.item], description: heroDescriptions[indexPath.item])
        }
    
    private func showHeroDetail(image: UIImage, name: String, description: String) {
        let secondStateView = SecondStateView()
        self.secondStateView = secondStateView
        secondStateView.configure(heroImage: image, heroName: name, heroDesc: description, onClose: { [weak self] in
            self?.hideHeroDetail()
        })
        view.addSubview(secondStateView)
        view.bringSubviewToFront(secondStateView)
        
        secondStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        secondStateView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            secondStateView.alpha = 1
        }
    }
    
    private func hideHeroDetail() {
           UIView.animate(withDuration: 0.3, animations: {
               self.secondStateView?.alpha = 0
           }, completion: { _ in
               self.secondStateView?.removeFromSuperview()
               self.secondStateView = nil
           })
       }
    
    
    
    
    private var collectionView: UICollectionView!
    let collectionLayout = CollectionViewPagingLayout()

    let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Logo")
        return logo
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = Constants.labelText
        label.font = Constants.firstFont
        label.textColor = .white
        return label
    }()
    
    
    func setupView() {
        view.addSubview(triangleView)
        triangleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 127, height: 27))
        }
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(111)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview().inset(203)
        }

    }

    
    private func makeCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        
        collectionView.isPagingEnabled = true
        collectionLayout.numberOfVisibleItems = nil
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: HeroCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.identifier, for: indexPath)
                as? HeroCollectionViewCell else {
            assertionFailure("couldn't dequeue cell")
            return UICollectionViewCell()
        }
        
        let image = self.cellImages[indexPath.item]
        let heroName = self.heroNames[indexPath.item]
        cell.configurate(image: image, heroName: heroName)
        return cell
    }
}




