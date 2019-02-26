//
//  FilmAttributesResponse.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation

public struct FilmAttributesResponse: Decodable {
    
    public struct Attributes: Decodable {
        public let id: Int
        public let name: String
    }
    
    public let data: [Attributes]
    
}
