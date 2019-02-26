//
//  OdeonFilm.swift
//  Domain
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import Foundation


public struct OdeonFilm: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "filmMasterId"
        case title
        case rating = "halfRating"
        case posterImageUrl = "posterUrl"
        case imageUrl
        case certificate
        case releaseDate
        case genre
        case trailerUrl
        case attributes
        case offers
    }

    public let id: Int
    public let title: String
    public let rating: Int
    public let posterImageUrl: URL
    public let imageUrl: URL
    public let certificate: Certificate
    public let releaseDate: DateWrapper<YearMonthDay>
    public let genre: String?
    public let trailerUrl: URL?
    public let attributes: String?
    public let offers: [Offer]

    func convertAttributes(using odeonAttributes: [FilmAttributesResponse.Attributes]) -> [FilmAttributesResponse.Attributes] {
        guard let attributes = attributes?.components(separatedBy: ",") else {
            return []
        }

        return odeonAttributes.filter { attribute -> Bool in
            attributes.contains(String(attribute.id))
        }
    }

}


public protocol DateFormat {
    static var dateFormat: String { get }
}

public struct YearMonthDayDashed: DateFormat {
    public static var dateFormat: String {
        return "yyyy-MM-dd"
    }
}

public struct YearMonthDay: DateFormat {
    public static var dateFormat: String {
        return "yyyyMMdd"
    }
}

private let dateFormatter = DateFormatter()

public struct DateWrapper<T: DateFormat>: Decodable {
    enum DateFormatError: Swift.Error {
        case invalidDateFormat
    }
    
    public let date: Date
    
    public init(from decoder: Decoder) throws {
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
