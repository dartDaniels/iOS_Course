//
//  ViewController.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 01.10.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTriangleOverlay()
        view.backgroundColor = .customBlack
        makeCollectionView()
        setupView()
    }
    
    var cellImages: [UIImage] = [UIImage(named: "HeroOne")!,
                                  UIImage(named: "HeroTwo")!,
                                  UIImage(named: "HeroThree")!
                                  ]
    
    var heroNames: [String] = ["Deadpool", "Iron Man", "Spider-Man"]
    
    
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
            make.leading.trailing.equalToSuperview().inset(45)
            make.size.equalTo(CGSize(width: 300, height: 550))
            make.top.equalToSuperview().inset(203)
            make.centerX.equalToSuperview()
        }
    }
    
    private func makeCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .customBlack
        collectionView.layer.cornerRadius = 10
        
        collectionView.collectionViewLayout = collectionLayout
        collectionView.isPagingEnabled = true
        collectionLayout.numberOfVisibleItems = nil
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        
        cell.configurate(image: cellImages[indexPath.item], name: heroNames[indexPath.item])
        return cell
    }


}




