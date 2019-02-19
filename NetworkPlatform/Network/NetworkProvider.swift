//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Domain


public final class NetworkProvider {
    
    
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "https://api.odeon.co.uk/android-3.6.0/api"
    }
    
    public func makeCinemaFilmNetwork() -> CinemaFilmNetwork {
        let network = Network<[OdeonFilmInCinema]>(apiEndpoint)
        return CinemaFilmNetwork(network: network)
    }
}
