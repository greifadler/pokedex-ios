//
//  Int+Extension.swift
//  student721009
//
//  Created by hohe on 14.10.23.
//

import Foundation

extension Int {
    func formatPokedexNumber() -> String {
        return String(format: "%03d", self)
    }
}
