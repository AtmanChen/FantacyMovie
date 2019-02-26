//
//  FilmsUseCase.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import RxSwift

public protocol FilmsUseCase {
    func newFilms() -> Observable<[OdeonFilm]>
    func topFilms() -> Observable<[OdeonFilm]>
    func recommendedFilms() -> Observable<[OdeonFilm]>
    func comingSoonFilms() -> Observable<[OdeonFilm]>
}
