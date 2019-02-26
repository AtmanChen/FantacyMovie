//
//  ListFilmsResponse.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation

public struct ListFilmsResponse: Decodable {
    
    public struct ListData: Decodable {
        public let films: [OdeonFilm]
    }
    
    public let data: ListData
    
}
