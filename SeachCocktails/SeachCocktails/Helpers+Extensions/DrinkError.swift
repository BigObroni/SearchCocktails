//
//  DrinkError.swift
//  SeachCocktails
//
//  Created by Nevan Bingham on 8/4/21.
//

import Foundation

enum DrinkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case couldNotDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach necessary URL"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "No data can be founds"
        case .couldNotDecode:
            return "Could not retrieve data for Drink Image"
        }
    }
}
