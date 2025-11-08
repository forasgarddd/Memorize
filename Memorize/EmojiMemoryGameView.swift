//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 01/11/2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
    
    init(viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
            Text("Score: \(viewModel.score)")
                .font(.title)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Text(viewModel.currentTheme.name)
                .font(.title)
            Spacer()
            Button("New Game") {
                viewModel.createNewGame()
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(viewModel.themeColor)
    }
    
    func flipRandomPairOfCards() {
        
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
