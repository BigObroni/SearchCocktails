//
//  Extensions.swift
//  SeachCocktails
//
//  Created by Nevan Bingham on 8/5/21.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    
}
