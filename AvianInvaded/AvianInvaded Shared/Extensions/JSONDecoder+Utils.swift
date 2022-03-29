//
//  JSONDecoder+Utils.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation

extension JSONDecoder {
    static func decode<T: Decodable>(to type: T.Type,
                                     from fileName: String,
                                     decoder: JSONDecoder = .init()) -> T? {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url, options: .mappedIfSafe),
            let decodedData = try? decoder.decode(T.self, from: data)
        else {
            return nil
        }
        
        return decodedData
    }
    
    static func decodeThrowing<T: Decodable>(to type: T.Type,
                                             from fileName: String,
                                             decoder: JSONDecoder = .init()) throws -> T {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            throw NSError(domain: "invalid", code: 1, userInfo: nil)
        }
        
        let data = try Data(contentsOf: url, options: .mappedIfSafe)
        let decodedData = try decoder.decode(T.self, from: data)
        
        return decodedData
    }
}
