//
//  Extenitons.swift
//  Netflix Clone
//
//  Created by Adem KOYAN on 16.02.2023.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
}
