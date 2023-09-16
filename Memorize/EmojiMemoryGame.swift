//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 13/09/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    
    private static let emojis = ["✌️", "🙏", "🖕", "🫶", "🤙", "👊", "🤌", "💪", "👋", "✍️", "🫵", "🤞"]
    
    private static let names = ["first theme", "second theme", "third theme"]
    
    private static let emojisSets = [["✌️", "🙏", "🖕", "🫶", "🤙", "👊", "🤌", "💪", "👋", "✍️", "🫵", "🤞"], ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🦝", "🐻", "🐼", "🦘", "🦡", "🐨", "🐯", "🦁"], ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🥭"]]
    
    private static let numbersOfPairsOfCards = [6, 8, 10]
    
    private static let colors = ["red", "yellow", "green"]

    private static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]

            }
            return "😅"
        }
    }
    
    private static func createNewMemoryGame() -> MemoryGame<String> {
        let theme = Theme.chooseRandomTheme(themes: createArrayOfThemes())
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            if theme.emojiSet.indices.contains(pairIndex) {
                return theme.emojiSet[pairIndex]

            }
            return "😅"
        }
    }
    
    private static func createArrayOfThemes() -> [Theme] {
        var setOfThemes : [Theme] = []
        for index in 0..<emojisSets.count {
            setOfThemes.append(Theme(name: names[index], emojiSet: emojisSets[index], numberOfPairsOfCards: numbersOfPairsOfCards[index], color: colors[index]))
        }
        return setOfThemes
    }
    
    var arrayOfThemes = createArrayOfThemes()
    
    @Published private var model = createMemoryGame()
    
    // @Published private var theme = createTheme()
    
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
