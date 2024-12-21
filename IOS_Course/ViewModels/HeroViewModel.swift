//
//  HeroViewModel.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 11.12.2024.
//

import Foundation
import Kingfisher
import UIKit
import CoreData
import RealmSwift

class HeroViewModel {
    
    private var heroes: [HeroModel] = []
    private var heroDescription: String?
    
    var reloadData: (() -> Void)?
    var onHeroDescriptionLoaded: ((String?) -> Void)?
    
    func fetchHeroes() {
            MarvelManager.shared.fetchHeroes { [weak self] result in
                switch result {
                case .success(let heroList):
                    self?.heroes = heroList
                    self?.reloadData?()
                    self?.saveHeroesToLocalStorage()
                case .failure:
                    let heroesFromLocal = self?.fetchHeroesFromLocalStorage()
                    if let heroesFromLocal = heroesFromLocal, !heroesFromLocal.isEmpty {
                        self?.heroes = heroesFromLocal
                        self?.reloadData?()
                    } else {
                        self?.reloadData?()
                    }
                }
            }
        }
    
    func saveHeroesToLocalStorage() {
            for hero in heroes {
                saveHeroToLocalStorage(hero: hero)
            }
        }
    
    func fetchHeroDescription(characterId: Int) {
        MarvelManager.shared.fetchHeroDetails(characterId: characterId) { [weak self] result in
            switch result {
            case .success(let heroDetails):
                let description = heroDetails.description
                self?.heroDescription = description
                self?.onHeroDescriptionLoaded?(description)
            case .failure:
                self?.onHeroDescriptionLoaded?(nil)
            }
        }
    }
    
    
    
    func saveHeroes(heroes: [HeroModel]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(heroes, update: .modified)
            }
        } catch {
            print("Ошибка при сохранении героев: \(error.localizedDescription)")
        }
    }
    
    func fetchHeroesFromRealm() -> [HeroModel]? {
        do {
            let realm = try Realm()
            let heroes = realm.objects(HeroModel.self)
            return Array(heroes)
        } catch {
            print("Ошибка при получении данных: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getHeroes() -> [HeroModel] {
        return heroes
    }
    
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
    
    func saveHeroToLocalStorage(hero: HeroModel) {
            let realm = try! Realm()
            
            let heroEntity = HeroModel()
            heroEntity.id = hero.id
            heroEntity.name = hero.name
            heroEntity.heroDescription = hero.description
            heroEntity.thumbnail = hero.thumbnail
            
            try! realm.write {
                realm.add(heroEntity, update: .modified)
            }
        }
    
    func fetchHeroDescriptionFromLocalStorage(heroId: Int) -> String? {
        let realm = try! Realm()
        if let heroEntity = realm.objects(HeroModel.self).filter("id == \(heroId)").first {
            return heroEntity.heroDescription
        }
        return heroDescription
    }
    
    func fetchHeroesFromLocalStorage() -> [HeroModel]? {
        let realm = try! Realm()
        let heroes = realm.objects(HeroModel.self)
        
        return Array(heroes)
    }
    func saveHeroDescriptionToLocalStorage(heroId: Int, description: String) {
        let realm = try! Realm()
        
        if let heroEntity = realm.objects(HeroModel.self).filter("id == \(heroId)").first {
            try! realm.write {
                heroEntity.heroDescription = description
            }
        } else {
            let heroEntity = HeroModel()
            heroEntity.id = heroId
            heroEntity.heroDescription = description
            try! realm.write {
                realm.add(heroEntity, update: .modified)
            }
        }
    }
}
