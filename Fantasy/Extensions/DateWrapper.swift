//
//  DateWrapper.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/19.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation


protocol DateFormat {
    static var dateFormat: String { get }
}

struct YearMonthDayDashed: DateFormat {
    static var dateFormat: String {
        return "yyyy-MM-dd"
    }
}

struct YearMonthDay: DateFormat {
    static var dateFormat: String {
        return "yyyyMMdd"
    }
}

private let dateFormatter = DateFormatter()

struct DateWrapper<T: DateFormat>: Decodable {
    enum DateFormatError: Swift.Error {
        case invalidDateFormat
    }

    let date: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawDateString = try container.decode(String.self)
        dateFormatter.dateFormat = T.dateFormat
        if let date = dateFormatter.date(from: rawDateString) {
            self.date = date
        } else {
            throw DateFormatError.invalidDateFormat
        }
    }
}
