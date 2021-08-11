//
//  DrinkViewController.swift
//  SeachCocktails
//
//  Created by Nevan Bingham on 8/5/21.
//

import UIKit

class DrinkViewController: UIViewController {

    @IBOutlet weak var drinkSearchBar: UISearchBar!
    
    @IBOutlet weak var drinkImageView: UIImageView!
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkSearchBar.delegate = self
    }

    func fetchDrinkThumbandUpdateViews(for drink: Drink) {
        
        DrinkController.fetchDrinkThumb(for: drink) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let drinkThumb):
                    self.drinkImageView.image = drinkThumb
                    self.drinkNameLabel.text = drink.strDrink
                    self.categoryNameLabel.text = drink.strCategory
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                    
                }
            }
        }
    }
}
extension DrinkViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        DrinkController.fetchDrink(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let topLevelObject):
                    self.fetchDrinkThumbandUpdateViews(for: topLevelObject)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
