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
    
    private var viewModel = HeroViewModel()
    private var heroes: [HeroModel] = []
    
    private let loaderView: UIView = {
        let loaderView = UIView()
        loaderView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loaderView.layer.cornerRadius = 10
        loaderView.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loaderView.addSubview(blurView)
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loaderView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor)
        ])
        
        return loaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.customBlack
        setupCollectionView()
        setupView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        showLoader()
        
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.heroes = self?.viewModel.getHeroes() ?? []
                self?.collectionView.reloadData()
                self?.hideLoader()
            }
        }

        viewModel.fetchHeroes()
                
    }
    
    
    
    private func showLoader() {
        DispatchQueue.main.async {
            self.loaderView.frame = self.view.bounds
            self.view.addSubview(self.loaderView)
        }
    }
        
    private func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView.removeFromSuperview()
        }
    }
    
    func createPagingLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    let triangleView = TriangleView()
    
    private var collectionView: UICollectionView!
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = Images.logo
        return logo
    }()
    
    let chooseHeroLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.chooseHeroText
        label.font = Fonts.bodyFont
        label.textColor = .white
        return label
    }()
    
    let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        button.tintColor = .white
        
        return button
    }()
    
    func setupView() {
        view.addSubview(triangleView)
        triangleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenSize.screenHeight/14.0666)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: screenSize.screenWidth/3.07, height: screenSize.screenHeight/31.260))
        }
        
        view.addSubview(chooseHeroLabel)
        chooseHeroLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenSize.screenHeight/7.603)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview().inset(screenSize.screenHeight/4.158)
        }
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createPagingLayout())
        collectionView.backgroundColor = .clear
                
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: HeroCollectionViewCell.identifier)
    }
}

extension HeroListViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfHeroes
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroCollectionViewCell.identifier, for: indexPath)
                as? HeroCollectionViewCell else {
            assertionFailure("couldn't dequeue cell")
            return UICollectionViewCell()
        }

        cell.configurate(with: viewModel.getHeroes(), at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroCardViewController = HeroCardViewController()

        navigationController?.pushViewController(heroCardViewController, animated: true)
        navigationItem.backBarButtonItem = backButton

        heroCardViewController.configure(with: viewModel, at: indexPath.item)
    }
}



