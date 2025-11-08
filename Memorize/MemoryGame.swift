//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 07/11/2025.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: [Card]
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
