//
//  TransparentNavigationViewController.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit

class TransparentNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emptyImage = UIImage()
        navigationBar.setBackgroundImage(emptyImage, for: .default)
        navigationBar.shadowImage = emptyImage
        navigationBar.isTranslucent = true
        
        navigationBar.tintColor = .white
        
        navigationBar.backIndicatorImage = emptyImage
        navigationBar.backIndicatorTransitionMaskImage = emptyImage
    }
    
    // MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Back Button
    
    lazy var backButton: UIBarButtonItem = {
        
        let button = UIButton(frame: .zero)
        button.frame.size = CGSize(width: 120, height: 44)
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        let imageView = UIImageView(image: UIImage(named: "Icons/back"))
        imageView.frame.origin = CGPoint(x: 5, y: 10)
        imageView.frame.size = CGSize(width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        
        return UIBarButtonItem(customView: button)
        
    }()
    
    @objc func didTapBack() {
        if viewControllers.count == 1 {
            dismiss(animated: trueUnlessReduceMotionEnabled, completion: nil)
        } else {
            popViewController(animated: trueUnlessReduceMotionEnabled)
        }
    }
    
    // MARK: - Share Button
    
    lazy var shareButton: UIBarButtonItem = {
        
        let button = UIButton(frame: .zero)
        button.frame.size = CGSize(width: 44, height: 44)
        button.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        
        let imageView = UIImageView(image: UIImage(named: "Icons/share"))
        imageView.frame.origin = CGPoint(x: 10, y: 10)
        imageView.frame.size = CGSize(width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        
        return UIBarButtonItem(customView: button)
        
    }()
    
    @objc func didTapShare() {
        print("Share")
    }
    
}
