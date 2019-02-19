//
//  DataWrapperGenericResponse.swift
//  NetworkPlatform
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation


struct DataWrapperGenericResponse<InnerData: Decodable>: Decodable {
    let data: InnerData
}
