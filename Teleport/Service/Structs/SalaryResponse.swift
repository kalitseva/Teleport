//
//  SalaryResponse.swift
//  Teleport
//
//  Created by Майя Калицева on 14.05.2022.
//


struct SalaryRoot: Decodable, Equatable {
    let salaries: [SalaryMiddle]
    
    enum CodingKeys: String, CodingKey {
        case salaries = "salaries"
    }
}

struct SalaryMiddle: Decodable, Equatable {
    let job: SalaryResponse
    let salaryPercentiles: SalaryPercentilesResponse
    
    enum CodingKeys: String, CodingKey {
        case job = "job"
        case salaryPercentiles = "salary_percentiles"
    }
}

struct SalaryResponse: Decodable, Equatable {
    let id: String
    let title: String
}

struct SalaryPercentilesResponse: Decodable, Equatable {
    let percentile25: Float
    let percentile50: Float
    let percentile75: Float
    
    enum CodingKeys: String, CodingKey {
        case percentile25 = "percentile_25"
        case percentile50 = "percentile_50"
        case percentile75 = "percentile_75"
    }
}


/*
struct SalaryCuries: Decodable, Equatable {
    let curies: [SalaryCuriesRoot]
}

struct SalaryCuriesRoot: Decodable, Equatable {
    let href: String
    let name: String
    let templated: Bool
}
*/
