//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 08/01/2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
