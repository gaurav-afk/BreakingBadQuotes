//
//  Character.swift
//  BB Quotes
//
//  Created by Gaurav Rawat on 2024-02-20.
//

import Foundation

struct Character: Decodable{
    
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
