//
//  DrinkController.swift
//  SeachCocktails
//
//  Created by Nevan Bingham on 8/4/21.
//

import Foundation
import UIKit.UIImage

class DrinkController {
    
    static let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php")
    
    static func fetchDrink(searchTerm: String, completion: @escaping (Result<Drink, DrinkError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "s", value: searchTerm)
        components?.queryItems = [searchQueryItem]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("DRINK STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(DrinkTopLevelObject.self, from: data)
                guard let drink = topLevelObject.drinks.first else { return completion(.failure(.couldNotDecode))}
                return completion(.success(drink))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchDrinkThumb(for drink: Drink, completion: @escaping (Result<UIImage, DrinkError>) -> Void) {
        
        guard let url = drink.strDrinkThumb else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("DRINKTHUMB STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let drinkThumb = UIImage(data: data) else { return completion(.failure(.couldNotDecode)) }
            return completion(.success(drinkThumb))
        }.resume()
    }
}
