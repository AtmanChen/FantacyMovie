//
//  CinemaFilm.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import Domain
import RxSwift


public final class CinemaFilmNetwork {
    
    private let network: Network<[OdeonFilmInCinema]>

    init(network: Network<[OdeonFilmInCinema]>) {
        self.network = network
        
    }
    
    public func getCinemaFilm() -> Observable<[OdeonFilmInCinema]> {
        let siteID = 181
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return network.getItems("films-by-cinema/s/\(siteID)/date/\(dateString)")
    }
    
}
