//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 13/09/2023.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairdsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card( content: content))
            cards.append(Card( content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
