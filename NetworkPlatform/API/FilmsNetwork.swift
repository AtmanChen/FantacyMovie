//
//  FilmsNetwork.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import Domain
import RxSwift


public final class FilmsNetwork {
    
    private let network: Network<[OdeonFilm]>
    
    init(network: Network<[OdeonFilm]>) {
        self.network = network
    }
    
    public func getNewFilms() -> Observable<[OdeonFilm]> {
        return network.getFilms("new-films")
    }
    
    public func getTopFilms() -> Observable<[OdeonFilm]> {
        return network.getFilms("top-films")
    }
    
    public func getRecommendedFilms() -> Observable<[OdeonFilm]> {
        return network.getFilms("recommended-films")
    }
    
    public func getComingsoonFilms() -> Observable<[OdeonFilm]> {
        return network.getFilms("coming-soon-films")
    }
    
}

