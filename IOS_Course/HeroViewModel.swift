//
//  HeroViewModel.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 11.12.2024.
//

import Foundation
import Kingfisher
import UIKit

class HeroViewModel {
    
    private var heroes: [HeroModel] = HeroModel.Heroes
    
    var numberOfHeroes: Int {
        return heroes.count
    }
    
    func getHero(at index: Int) -> HeroModel {
        return heroes[index]
    }
    
    @MainActor func ImageLoader(from url: String, for heroView: UIImageView, placeholder: UIImage?, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .black
        heroView.addSubview(indicator)
        indicator.startAnimating()
        heroView.center = CGPoint(x: heroView.bounds.midX, y: heroView.bounds.midY)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: heroView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: heroView.centerYAnchor)
        ])
        
        DispatchQueue.main.async {
            indicator.startAnimating()
            heroView.kf.setImage(with: imageURL, placeholder: placeholder)
            { result in
                indicator.stopAnimating()
                indicator.hidesWhenStopped = true
                
                switch result {
                case .success(let value):
                    completion(value.image)
                case .failure:
                    completion(placeholder)
                }
            }
            
        }
    }
}
