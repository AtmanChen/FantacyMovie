//
//  HomeHeaderView.swift
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
import RxCocoa

class HomeHeaderView: UIView, ConfigurableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleNavigationBarLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    

    private let disposeBag = DisposeBag()
    
    func configure(with object: Any?) {
        guard let object = object as? OdeonFilmInCinema.Film else {
            return
        }
        titleLabel.text = object.title
        titleNavigationBarLabel.text = object.title
        secondaryLabel.text = nil
        Nuke.ImagePipeline.shared.rx.loadImage(with: object.imageURL)
            .map { $0.image }
            .asDriver(onErrorJustReturn: UIImage())
            .drive(backgroundImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
}
