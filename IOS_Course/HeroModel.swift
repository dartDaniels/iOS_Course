//
//  HeroModel.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 20.11.2024.
//

import UIKit

class HeroModel {
    let cellImages: [UIImage] = [UIImage(named: "HeroOne") ?? UIImage(),
                                  UIImage(named: "HeroTwo") ?? UIImage(),
                                  UIImage(named: "HeroThree") ?? UIImage()
                                  ]
    let heroNames: [String] = ["Deadpool", "Iron Man", "Spider-Man"]
    
    let heroDescriptions: [String] = ["Please don’t make the super suit green...or animated!",
                            "I AM IRON MAN",
                            "In iron suit"]
}
