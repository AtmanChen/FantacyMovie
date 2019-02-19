//
//  Network.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation
import RxSwift
import Domain
import Alamofire
import RxAlamofire

final class Network<T: Decodable> {
    
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: .background, relativePriority: 1))
    }
    
    
    func getItems(_ path: String) -> Observable<T> {
        let absoluePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .data(.get, absoluePath)
            .debug()
            .observeOn(scheduler)
            .map { data -> T in
                let response = try JSONDecoder().decode(DataWrapperGenericResponse<T>.self, from: data)
                return response.data
            }
    }
}
