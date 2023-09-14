//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 13/09/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let emojis = ["✌️", "👋", "🖕", "🫶", "🤙", "👊", "🤌", "💪", "👋", "✍️", "🫵", "🤞"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]

            }
            return "😅"
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
