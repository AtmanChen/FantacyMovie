//
//  CinemaUseCase.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import RxSwift


public protocol CinemaUseCase {
    func cinemaFilm() -> Observable<[OdeonFilmInCinema]>
}
