//
//  HeroModel.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 20.11.2024.
//

import UIKit
import Kingfisher
import RealmSwift

class HeroModel: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var heroDescription = ""
    @objc dynamic var thumbnail: ThumbnailModel?

    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case heroDescription = "description"
        case thumbnail
    }
}

class ThumbnailModel: Object, Decodable {
    @objc dynamic var path = ""
    @objc dynamic var `extension` = ""
    
    var fullURL: String? {
        guard !path.isEmpty, !`extension`.isEmpty else {
            return nil
        }
        return "\(path).\(`extension`)"
    }

    enum CodingKeys: String, CodingKey {
        case path
        case `extension`
    }
}

struct HeroList: Decodable {
    let data: HeroData
}

struct HeroData: Decodable {
    let results: [HeroModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
