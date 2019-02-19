//
//  Certificate.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import UIKit

public enum Certificate: String, Codable {
    
    case toBeConfirmed = "TBC"
    case universal = "U"
    case parentalGuidance = "PG"
    case twelveA = "12A"
    case twelve = "12"
    case fifteen = "15"
    case eighteen = "18"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValueDecoded = try container.decode(String.self)
        
        switch rawValueDecoded {
        case "TBC": self = .toBeConfirmed
        case "U": self = .universal
        case "PG": self = .parentalGuidance
        case "12A": self = .twelveA
        case "12": self = .twelve
        case "15": self = .fifteen
        case "18": self = .eighteen
        default: self = .unknown
        }
    }
    
    public var image: UIImage? {
        switch self {
        case .toBeConfirmed:
            return UIImage(named: "Icons/Certificates/TBC")
        case .universal:
            return UIImage(named: "Icons/Certificates/U")
        case .parentalGuidance:
            return UIImage(named: "Icons/Certificates/PG")
        case .twelveA:
            return UIImage(named: "Icons/Certificates/12A")
        case .twelve:
            return UIImage(named: "Icons/Certificates/12")
        case .fifteen:
            return UIImage(named: "Icons/Certificates/15")
        case .eighteen:
            return UIImage(named: "Icons/Certificates/18")
        case .unknown:
            return nil
        }
    }
    
    public var infoURL: URL {
        return URL(string: "https://www.odeon.co.uk/film-classifications/")!
    }
    
}
