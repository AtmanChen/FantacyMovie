//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        self.networkProvider = NetworkProvider()
    }
    
    public func makeCinemaUseCase() -> Domain.CinemaUseCase {
        return CinemaUseCase(network: networkProvider.makeCinemaFilmNetwork())
    }
    
    public func makeFilmsUseCase() -> Domain.FilmsUseCase {
        return FilmsUseCase(network: networkProvider.makeFilmsNetwork())
    }
    
}

