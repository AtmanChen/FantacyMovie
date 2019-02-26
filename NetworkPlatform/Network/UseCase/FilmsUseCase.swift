//
//  FilmUseCase.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class FilmsUseCase: Domain.FilmsUseCase {
   
    private let network: FilmsNetwork
    
    init(network: FilmsNetwork) {
        self.network = network
    }
    
    func newFilms() -> Observable<[OdeonFilm]> {
        return network.getNewFilms()
    }
    
    func topFilms() -> Observable<[OdeonFilm]> {
        return network.getTopFilms()
    }
    
    func recommendedFilms() -> Observable<[OdeonFilm]> {
        return network.getRecommendedFilms()
    }
    
    func comingSoonFilms() -> Observable<[OdeonFilm]> {
        return network.getComingsoonFilms()
    }
    
    
}
