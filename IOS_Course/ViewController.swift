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
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview().inset(203)
            
        }
    }
    
    private func makeCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        
        collectionView.collectionViewLayout = collectionLayout
        collectionView.isPagingEnabled = true
        collectionLayout.numberOfVisibleItems = nil
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        addTriangleOverlay()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
                as? CustomCollectionViewCell else {
                    fatalError("Could not dequeue ImageCell")
                }
        
        let image = self.cellImages[indexPath.row]
        let name = self.heroNames[indexPath.row]
        cell.configurate(image: image, name: name)
        return cell

    }
    
    


}




