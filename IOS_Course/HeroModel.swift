//
//  HeroModel.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 20.11.2024.
//

import UIKit
import Kingfisher

struct HeroModel {
    let heroName: String
    let heroDescription: String
    let heroURL: String
    
    static let Heroes: [HeroModel] = [ HeroModel(heroName: "Deadpool", heroDescription: "Please don’t make the super\n suit green...or   animated!", heroURL: "https://iili.io/JMnAfIV.png"),
                                       HeroModel(heroName: "Iron Man", heroDescription: "I AM IRON MAN", heroURL: "https://iili.io/JMnuDI2.png"),
                                       HeroModel(heroName: "Spider-Man", heroDescription: "In iron suit", heroURL: "https://iili.io/JMnuyB9.png")]
}
