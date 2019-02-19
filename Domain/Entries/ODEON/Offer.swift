//
//  Offer.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation


public struct Offer: Codable {
    
    public struct Images: Codable {
        
        enum CodingKeys: String, CodingKey {
            case thumbnail = "140x140"
            case medium = "300x170"
            case large = "460x260"
        }
        
        let thumbnail: String
        let medium: String
        let large: String
        
    }
    
    public enum OfferType: String, Codable {
        case offer
        case competition
    }
    
    public let id: Int
    public let title: String
    public let teaser: String
    public let text: String
    public let terms: String
    public let validFrom: String // TODO: Make this date (2018-12-12 00:30:00)
    public let validTo: String // TODO: Make this date (2018-12-12 00:30:00)
    public let type: OfferType
    public let images: Images
    
}
