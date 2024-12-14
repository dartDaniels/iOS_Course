//
//  Constants.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 03.11.2024.
//

import Foundation
import UIKit

struct Strings {
    static let chooseHeroText = "Choose your hero"
}

struct Fonts {
    static let heroNameFont = UIFont.systemFont(ofSize: .init(34), weight: .bold)
    static let largeTitle = UIFont.systemFont(ofSize: .init(32), weight: .bold)
    static let bodyFont = UIFont.systemFont(ofSize: .init(28), weight: .bold)
    static let heroDescriptionFont = UIFont.systemFont(ofSize: .init(22), weight: .bold)
}

struct Images {
    static let logo = UIImage(named: "Logo")
    static let backButtonImage = UIImage(named: "BackButton")
    static let heroPlaceholder = UIImage(named: "placeholder")
    
}

struct Colors {
    static let customBlack = UIColor(red: 43/255, green: 39/255, blue: 43/255, alpha: 1)
    static let customRed = UIColor(red: 148/255, green: 20/255, blue: 25/255, alpha: 1)
    static let customCherry = UIColor(red: 153/255, green: 21/255, blue: 24/255, alpha: 1)
}

struct screenSize {
    static let screenBoundsSize = UIScreen.main.bounds.size
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
}
