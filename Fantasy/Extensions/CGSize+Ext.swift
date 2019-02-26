//
//  CGSize+Ext.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/21.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit

enum AspectRatio {
    case poster
    case headshot
    
    var size: CGSize {
        switch self {
        case .poster: return CGSize(width: 11, height: 16)
        case .headshot: return CGSize(width: 2, height: 2.5)
        }
    }
}

extension CGSize {
    
    init(width: CGFloat, aspectRatio: AspectRatio) {
        let aspectRatioDecimal = aspectRatio.size.asAspectRatioDecimal
        self.init(width: width, height: aspectRatioDecimal * width)
    }
    
    init(height: CGFloat, aspectRatio: AspectRatio) {
        let aspectRatioDecimal = aspectRatio.size.asAspectRatioDecimal
        self.init(width: height / aspectRatioDecimal, height: height)
    }
    
    var asAspectRatioDecimal: CGFloat {
        return height / width
    }
    
}
