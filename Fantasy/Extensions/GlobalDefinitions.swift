//
//  GlobalDefinitions.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit

typealias VoidClosure = () -> Void

func assertNotNil(_ condition: @autoclosure () -> Optional<Any>, file: StaticString = #file, line: UInt = #line) {
    
    if case .none = condition() {
        assertionFailure(file: file, line: line)
    }
    
}

var trueUnlessReduceMotionEnabled: Bool {
    if UIAccessibility.isReduceMotionEnabled {
        return false
    }
    
    return true
}
