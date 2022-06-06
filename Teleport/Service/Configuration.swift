//
//  Configuration.swift
//  Teleport
//
//  Created by Майя Калицева on 27.04.2022.
//

import Foundation

enum Configuration {
    
    static let base = "api.teleport.org"
    static let baseDomain = "\(base)/api/"
    
    static let baseUrl: URL = {
        
        let urlString = "https://\(baseDomain)"
        guard let url = URL(string: urlString) else {
            fatalError("Unable to init URL for \(urlString)")
        }
        return url
    }()
    
    static let startUrlString = "https://\(baseDomain)"
}
