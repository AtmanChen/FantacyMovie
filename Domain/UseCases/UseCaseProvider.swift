//
//  CinemaUseCaseProvider.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeCinemaUseCase() -> CinemaUseCase
    func makeFilmsUseCase() -> FilmsUseCase
}
