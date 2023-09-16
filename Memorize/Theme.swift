//
//  Theme.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 16/09/2023.
//

import Foundation

struct Theme {
    
    let name: String
    
    let emojiSet: [String]
    
    var numberOfPairsOfCards: Int
    
    let color: String
    
    init(name: String, emojiSet: [String], numberOfPairsOfCards: Int, color: String) {
        self.name = name
        self.emojiSet = emojiSet
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.color = color
    }
    
    static func chooseRandomTheme(themes: [Theme]) -> Theme {
        return themes.randomElement() ?? Theme(name: "", emojiSet: [], numberOfPairsOfCards: 0, color: "")
    }
    
}
