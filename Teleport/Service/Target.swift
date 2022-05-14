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
    case allContinents
    case continentsCountries(String)
    case allUrbanAreas
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
        case .allContinents:
            return "continents/"
        case .continentsCountries(let id):
            return "continents\(id)countries"
        case .allUrbanAreas:
            return "/urban_areas/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allCountries, .allContinents, .continentsCountries, .allUrbanAreas:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .allCountries, .allContinents, .continentsCountries, .allUrbanAreas:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

