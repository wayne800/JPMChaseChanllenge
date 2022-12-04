//
//  ObjectProvider.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

struct ObjectDecoder {
    func decodeObject<T: Codable>(with data: Data) -> Result<T, ErrorType> {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return Result.success(object)
        } catch(_) {
            return Result.failure(.decodeError)
        }
    }
}
