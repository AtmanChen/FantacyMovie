//
//  ScrollerImageViewModel.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/21.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import Domain

struct ScrollerImageViewModel {
    
    let title: String
    let imageURL: URL?
    let aspectRatio: AspectRatio
    
    let secondaryText: String?
    let halfRating: Int?
    let certificate: Certificate?
    
}
