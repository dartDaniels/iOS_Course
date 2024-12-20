//
//  MarvelManager.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 16.12.2024.
//

import Foundation
import Alamofire
import CommonCrypto

final class MarvelManager {
    static let shared = MarvelManager()

    private let baseURL = "https://gateway.marvel.com/v1/public"
    private let publicKey = ApiKey.publicKey
    private let privateKey = ApiKey.privateKey
    private let timestamp = "\(Int(Date().timeIntervalSince1970))"

    private var hash: String

    init() {
        let hashString = "\(timestamp)\(privateKey)\(publicKey)"
        self.hash = hashString.md5
    }

    func fetchHeroes(completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        let endpoint = "/characters"
        
        let parameters: Parameters = [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": hash
        ]
        
        AF.request(baseURL + endpoint, parameters: parameters)
            .validate()
            .responseDecodable(of: HeroList.self) { response in
                switch response.result {
                case .success(let heroListResponse):
                    completion(.success(heroListResponse.data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchHeroDetails(characterId: Int, completion: @escaping (Result<HeroModel, Error>) -> Void) {
        let endpoint = "/characters/\(characterId)"
        
        let parameters: Parameters = [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": hash
        ]
        
        AF.request(baseURL + endpoint, parameters: parameters)
            .validate()
            .responseDecodable(of: HeroList.self) { response in
                switch response.result {
                case .success(let heroListResponse):
                    guard let heroDetails = heroListResponse.data.results.first else {
                        completion(.failure(NSError(domain: "MarvelManagerError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Hero details not found"])))
                        return
                    }
                    completion(.success(heroDetails))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


extension String {
    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: length)
        
        _ = messageData.withUnsafeBytes {
            _ = CC_MD5($0.baseAddress, CC_LONG(messageData.count), &digest)
        }
        
        let md5String = digest.map { String(format: "%02hhx", $0) }.joined()
        return md5String
    }
}


