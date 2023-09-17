//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 13/09/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let emojis = ["✌️", "🙏", "🖕", "🫶", "🤙", "👊", "🤌", "💪", "👋", "✍️", "🫵", "🤞"]
    
    private static let theme1 = Theme(name: "first theme", emojiSet: ["✌️", "🙏", "🖕", "🫶", "🤙", "👊", "🤌", "💪", "👋", "✍️", "🫵", "🤞"], numberOfPairsOfCards: 6, color: "red")
    
    private static let theme2 = Theme(name: "second theme", emojiSet: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🦝", "🐻", "🐼", "🦘", "🦡", "🐨", "🐯", "🦁"], numberOfPairsOfCards: 8, color: "yellow")
    
    private static let theme3 = Theme(name: "third theme", emojiSet: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🥭"], numberOfPairsOfCards: 10, color: "green")
    
    private static var chosenTheme = Theme(name: "", emojiSet: [], numberOfPairsOfCards: 0, color: "")

    private static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]

            }
            return "😅"
        }
    }
    
    private static func createNewMemoryGame() -> MemoryGame<String> {
        guard let chosenTheme = createArrayOfThemes().randomElement() else {return createNewMemoryGame()}
        EmojiMemoryGame.chosenTheme = chosenTheme
        return MemoryGame(numberOfPairsOfCards: chosenTheme.numberOfPairsOfCards) { pairIndex in
                if chosenTheme.emojiSet.indices.contains(pairIndex) {
                    return chosenTheme.emojiSet[pairIndex]
                }
                return "😅"
            }
        }
    
    private static func createArrayOfThemes() -> [Theme] {
        var arrayOfThemes : [Theme] = []
        arrayOfThemes.append(theme1)
        arrayOfThemes.append(theme2)
        arrayOfThemes.append(theme3)
        
        return arrayOfThemes
        
    }
        
    @Published private var model = createNewMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        
    }
    
    func newGame() {
        model = EmojiMemoryGame.createNewMemoryGame()
        model.shuffle()
    
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func setColor() -> Color {
        switch EmojiMemoryGame.chosenTheme.color {
        case "red":
            return Color.red
        case "green":
            return Color.green
        case "yellow":
            return Color.yellow
        default:
            return Color.accentColor
        }

        
    }
    
    
}
