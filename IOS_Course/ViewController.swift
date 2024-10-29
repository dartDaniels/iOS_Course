//
//  ViewController.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 01.10.2024.
//

import SnapKit
import UIKit
import CollectionViewPagingLayout


class ViewController: UIViewController, UICollectionViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTriangleOverlay()
        view.backgroundColor = .customBlack
        makeCollectionView()
        addSubviews()
    }
    
    var cellImages: [UIImage?] = [UIImage(named: "HeroOne"),
                                  UIImage(named: "HeroTwo"),
                                  UIImage(named: "HeroThree"),
                                  ]
    
    var heroNames: [String?] = ["Deadpool", "Iron Man", "Spider-Man"]
    
    
    private var collectionView: UICollectionView!
    //let layout = PagingCollectionViewLayout()
    let collectionLayout = CollectionViewPagingLayout()

    let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "Logo")
        return logo
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Choose your hero"
        label.font = UIFont.systemFont(ofSize: .init(28), weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private func addTriangleOverlay() {
            let shapeLayer = CAShapeLayer()
            let trianglePath = UIBezierPath()
            
            let startPoint = CGPoint(x: -58, y: 900)
            let secondPoint = CGPoint(x: 500, y: 900)
            let thirdPoint = CGPoint(x: view.bounds.midX+255, y: view.bounds.midY-170)
            
            trianglePath.move(to: startPoint)
            trianglePath.addLine(to: secondPoint)
            trianglePath.addLine(to: thirdPoint)
            trianglePath.close()
            
            shapeLayer.path = trianglePath.cgPath
            shapeLayer.fillColor = UIColor.customRedOne.cgColor
            shapeLayer.lineWidth = 2
            
            view.layer.addSublayer(shapeLayer)
        }
    
    
    func addSubviews() {
        
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
        
//        layout.itemSize = CGSize(width: 300, height: 550)
//        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .horizontal
//        layout.numberOfItemsPerPage = 1
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        cell.configurate(image: cellImages[indexPath.item], name: heroNames[indexPath.item], description: "hell")
        return cell
    }


}




