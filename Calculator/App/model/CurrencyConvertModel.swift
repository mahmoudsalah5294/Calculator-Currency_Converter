//
//  CurrencyConvertModel.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 29/06/2021.
//

import Foundation

struct CurrencyConvertModel : Codable {
    let result : String?
    let documentation : String?
    let terms_of_use : String?
    let time_last_update_unix : Int?
    let time_last_update_utc : String?
    let time_next_update_unix : Int?
    let time_next_update_utc : String?
    let base_code : String?
    let target_code : String?
    let conversion_rate : Double?
    let conversion_result : Double?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case documentation = "documentation"
        case terms_of_use = "terms_of_use"
        case time_last_update_unix = "time_last_update_unix"
        case time_last_update_utc = "time_last_update_utc"
        case time_next_update_unix = "time_next_update_unix"
        case time_next_update_utc = "time_next_update_utc"
        case base_code = "base_code"
        case target_code = "target_code"
        case conversion_rate = "conversion_rate"
        case conversion_result = "conversion_result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        documentation = try values.decodeIfPresent(String.self, forKey: .documentation)
        terms_of_use = try values.decodeIfPresent(String.self, forKey: .terms_of_use)
        time_last_update_unix = try values.decodeIfPresent(Int.self, forKey: .time_last_update_unix)
        time_last_update_utc = try values.decodeIfPresent(String.self, forKey: .time_last_update_utc)
        time_next_update_unix = try values.decodeIfPresent(Int.self, forKey: .time_next_update_unix)
        time_next_update_utc = try values.decodeIfPresent(String.self, forKey: .time_next_update_utc)
        base_code = try values.decodeIfPresent(String.self, forKey: .base_code)
        target_code = try values.decodeIfPresent(String.self, forKey: .target_code)
        conversion_rate = try values.decodeIfPresent(Double.self, forKey: .conversion_rate)
        conversion_result = try values.decodeIfPresent(Double.self, forKey: .conversion_result)
    }

}
