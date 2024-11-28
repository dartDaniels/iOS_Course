//
//  ViewController.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 01.10.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout
import Kingfisher

class HeroListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack
        makeCollectionView()
        setupView()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func createPagingLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 0

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    let heroModel = HeroModel()
    let triangleView = TriangleView()
    
    private var collectionView: UICollectionView!
    
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
        let layout = CollectionViewPagingLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createPagingLayout())
        collectionView.backgroundColor = .clear
        
        collectionView.isPagingEnabled = true
        layout.numberOfVisibleItems = nil
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: HeroCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroModel.heroURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.identifier, for: indexPath)
                as? HeroCollectionViewCell else {
            assertionFailure("couldn't dequeue cell")
            return UICollectionViewCell()
        }
        
        let heroURL = heroModel.heroURL[indexPath.item]
        let heroName = heroModel.heroNames[indexPath.item]

        cell.configurate(image: heroURL, heroName: heroName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = SecondStateViewController()
        secondViewController.modalPresentationStyle = .fullScreen

        let heroURL = heroModel.heroURL[indexPath.item]
        let heroName = heroModel.heroNames[indexPath.item]
        let heroDescriptions = heroModel.heroDescriptions[indexPath.item]

        secondViewController.configure(heroImage: heroURL, heroName: heroName, heroDesc: heroDescriptions)
        present(secondViewController, animated: true, completion: nil)
    }
}




