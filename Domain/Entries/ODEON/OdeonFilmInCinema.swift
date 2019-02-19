//
//  OdeonFilmInCinema.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation


public struct OdeonFilmInCinema: Decodable {
    public struct Film: Decodable {
        enum CodingKeys: String, CodingKey {
            case id = "filmMasterId"
            case title, certificate, genre
            case rating = "halfRating"
            case posterImageURL = "poster220x320Url"
            case imageURL = "imageUrl"
        }
        
        public let id: Int
        public let title: String
        public let certificate: Certificate
        public let genre: String?
        public let rating: Int
        public let posterImageURL: URL
        public let imageURL: URL
    }
    
    public let film: Film
}
