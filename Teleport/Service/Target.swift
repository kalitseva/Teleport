//
//  Target.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import Foundation
import Moya

enum Target {
    case allCountries
}

extension Target: TargetType {
    
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    var baseURL: URL { Configuration.baseUrl }
    
    var path: String {
        switch self {
        case .allCountries:
            return "countries/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allCountries:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .allCountries:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

