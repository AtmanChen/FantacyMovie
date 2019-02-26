//
//  DataWrapperGenericResponse.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation

public struct DataWrapperGenericResponse<InnerData: Decodable>: Decodable {
    public let data: InnerData
}
