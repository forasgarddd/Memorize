//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 07/11/2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes = [
                                Theme(name: "Animals", emojis: ["🐶", "🐱", "🐰", "🦊", "🐻", "🐷", "🐭", "🐹", "🐸", "🐯"], numberOfPairsOfCards: 8, color: "green"),
                                Theme(name: "Emotions", emojis: ["😊", "😔", "😡", "😮", "😲", "😅"], numberOfPairsOfCards: 6, color: "blue"),
                                Theme(name: "Food", emojis: ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇"], numberOfPairsOfCards: 4, color: "yellow"),
                                Theme(name: "Flags", emojis: ["🇮🇹", "🇩🇪", "🇪🇸", "🇫🇷", "🇬🇧", "🇺🇸", "🇧🇪", "🇦🇱", "🇩🇰", "🇳🇴"], numberOfPairsOfCards: 10, color: "red"),
                                Theme(name: "Objects", emojis: ["📚", "🔧", "🔍", "💻", "🎮", "🧳", "🎨", "🎭", "🎥", "🎶"], numberOfPairsOfCards: 8, color: "purple"),
                                Theme(name: "Transportation", emojis: ["🚗", "🚄", "🚀", "🚆", "🚂", "🚃", "🚌", "🚎", "🚙", "🚜", "🚔", "🚖"], numberOfPairsOfCards: 12, color: "orange")
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards
        ) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }

        }
    }
    
    private static func randomTheme() -> Theme {
        return themes.randomElement()!
    }
    
    private static func makeGame() -> (MemoryGame<String>, Theme) {
        var theme = EmojiMemoryGame.randomTheme()
        theme.emojis.shuffle()
        let model = EmojiMemoryGame.createMemoryGame(theme: theme)
        return (model, theme)
    }
    
    @Published private var model: MemoryGame<String>
    
    var currentTheme: Theme
    
    init() {
        (model, currentTheme) = EmojiMemoryGame.makeGame()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeColor: Color {
        switch currentTheme.color {
        
        case "green":
            return .green
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "red":
            return .red
        case "purple":
            return .purple
        case "orange":
            return .orange
        case "cyan":
            return .cyan
        case "brown":
            return .brown
        case "indigo":
            return .indigo
        case "mint":
            return .mint
        case "pink":
            return .pink
        case "teal":
            return .teal
        default:
            return .black
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func createNewGame() {
        (model, currentTheme) = EmojiMemoryGame.makeGame()
    }
}

