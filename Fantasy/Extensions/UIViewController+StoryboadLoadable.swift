//
//  UIViewController+StoryBoadLoadable.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit

protocol StoryboadLoadable {
    static var storyboardName: String { get }
    static var viewControllerIdentifier: String? { get }
}

extension StoryboadLoadable where Self: UIViewController {
    
    
    static var viewControllerIdentifier: String? {
        return nil
    }
    
    static func New() -> Self {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        if let vcId = viewControllerIdentifier {
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: vcId) as? Self else {
                fatalError("Failed to load UIViewController with identifier: \(vcId)")
            }
            return viewController
        }
        guard let viewController = storyBoard.instantiateInitialViewController() as? Self else {
            fatalError("Failed to load UIViewController with storyboard name: \(storyboardName)")
        }
        return viewController
    }
    
}

