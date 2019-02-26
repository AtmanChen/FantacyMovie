//
//  CinemaUseCase.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class CinemaUseCase: Domain.CinemaUseCase {
   
    private let network: CinemaFilmNetwork
    
    init(network: CinemaFilmNetwork) {
        self.network = network
    }
    
    func cinemaFilm() -> Observable<[OdeonFilmInCinema]> {
        return network.getCinemaFilm()
    }
}
