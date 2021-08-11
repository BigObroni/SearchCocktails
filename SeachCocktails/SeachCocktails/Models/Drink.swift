//
//  Cocktail.swift
//  SeachCocktails
//
//  Created by Nevan Bingham on 8/4/21.
//

import Foundation

struct DrinkTopLevelObject: Decodable {
    let drinks: [Drink]
}

struct Drink: Decodable {
    let strDrink: String
    let strCategory: String
    let strDrinkThumb: URL?
}
