//
//  HeroModel.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 20.11.2024.
//

import UIKit
import Kingfisher

struct HeroModel: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailModel
}

struct ThumbnailModel: Codable {
    let path: String
    let `extension`: String
    
    var fullURL: String? {
            guard !path.isEmpty, !`extension`.isEmpty else {
                return nil
            }
            return "\(path).\(`extension`)"
        }
}

struct HeroList: Codable {
    let data: HeroData
}

struct HeroData: Codable {
    let results: [HeroModel]
}

