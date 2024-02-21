//
//  Constants.swift
//  BB Quotes
//
//  Created by Gaurav Rawat on 2024-02-20.
//

import Foundation

enum Constants{
    static let bbName = "Breaking Bad"
    static let bcsName = "Better Call Saul"
}

extension String{
    var replaceSpaceWithPlus: String{
        replacingOccurrences(of: "", with: "+")
    }
    
    var noSpaces: String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    var lowerNoSpaces: String{
        self.noSpaces.lowercased()
    }
}
