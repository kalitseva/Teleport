//
//  ScoresResponse.swift
//  Teleport
//
//  Created by Майя Калицева on 25.05.2022.
//

import Foundation
import UIKit

struct ScoresRoot: Decodable, Equatable {
    let categories: ScoresResponse
}

struct ScoresResponse: Decodable, Equatable {
    let color: String
    let name: String
    let score: Double
    let summary: String
    let teleportScore: Double
    
    enum CodingKeys: String, CodingKey {
        case color = "color"
        case name = "name"
        case score = "score_out_of_10"
        case summary = "summary"
        case teleportScore = "teleport_city_score"
        
    }
}

