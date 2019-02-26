//
//  ScrollerImageCollectionViewCell.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit
import Domain
import Nuke
import RxNuke
import RxSwift

class ScrollerImageCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var certificateImageView: UIImageView!
    fileprivate var disposeBag = DisposeBag()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = UIImage()
        disposeBag = DisposeBag()
    }
    
}



extension ScrollerImageCollectionViewCell: ClassIdentifiable, NibIdentifiable {}

extension ScrollerImageCollectionViewCell: ConfigurableCell {
    func configure(with object: Any?) {
        guard let film = object as? ScrollerImageViewModel else {
            return
        }
        Nuke.ImagePipeline.shared.rx.loadImage(with: film.imageURL!)
            .map { $0.image }
            .asDriver(onErrorJustReturn: UIImage())
            .drive(mainImageView.rx.image)
            .disposed(by: disposeBag)
        titleLabel.text = film.title
        certificateImageView.image = film.certificate?.image
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        secondaryLabel.text = film.secondaryText
        setStarCount(film.halfRating ?? 0)
    }
    
    func setStarCount(_ halfRating: Int) {
        
        // Collect and validate assets
        
        let fullImage = UIImage(named: "Icons/Star/filled")?.withRenderingMode(.alwaysTemplate)
        let halfImage = UIImage(named: "Icons/Star/half")?.withRenderingMode(.alwaysTemplate)
        
        assert(fullImage != nil)
        assert(halfImage != nil)
        
        let activeColour = UIColor(named: "Profile/StarActive")
        let inactiveColour = UIColor(named: "Profile/StarInactive")
        
        assert(activeColour != nil)
        assert(inactiveColour != nil)
        
        // Define helper blocks for mapping star to assets
        
        let imageForRating: (Int) -> UIImage? = { tag in
            
            if halfRating >= tag * 2 {
                return fullImage
            }
            
            if halfRating >= (tag * 2) - 1 {
                return halfImage
            }
            
            return fullImage
            
        }
        
        let colourForRating: (Int) -> UIColor? = { tag in
            
            if halfRating >= (tag * 2) - 1 {
                return activeColour
            }
            
            return inactiveColour
            
        }
        
        // Apply assets to each star in container
        
        for view in starStackView.arrangedSubviews {
            
            guard let imageView = view as? UIImageView else {
                continue
            }
            
            imageView.image = imageForRating(view.tag)
            imageView.tintColor = colourForRating(view.tag) ?? .black
            
        }
        
    }
}
