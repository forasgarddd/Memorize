//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 06/09/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var cardCount: Int = 0
    
    @State var chosenTheme: Array<String> = []
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            //cardCountAdjusters
            //themeChooseButtons
        }
        .padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > chosenTheme.count)
    }
    
    func chooseTheme(theme: [String], symbol: String, text: String) -> some View {
        Button(action: {
            chosenTheme = theme
            chosenTheme.shuffle()
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .font(.system(size: 50))
                Text(text)
                    .font(.system(size: 15))
            }
        })
    }
    
    var chooseTheme1: some View {
        chooseTheme(theme: ["🐶", "🐶", "🦊", "🦊", "🐱", "🐱", "🐻", "🐻", "🦁", "🦁"], symbol: "pawprint", text: "Animals")
    }
    
    var chooseTheme2: some View {
        chooseTheme(theme: ["✌️", "✌️", "👋", "👋", "🖕", "🖕", "🫶", "🫶", "🤙", "🤙", "👊", "👊", "🤌", "🤌", "💪", "💪"], symbol: "hand.wave", text: "Gestures")
    }
    
    var chooseTheme3: some View {
        chooseTheme(theme: ["🇦🇷", "🇦🇷", "🇪🇸", "🇪🇸", "🇬🇧", "🇬🇧", "🇺🇦", "🇺🇦", "🇺🇸", "🇺🇸", "🇨🇳", "🇨🇳", "🇵🇱", "🇵🇱", "🇧🇷", "🇧🇷", "🇫🇷", "🇫🇷", "🇩🇪", "🇩🇪"], symbol: "globe.europe.africa", text: "Countries")
    }
        
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.green)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            
            cardAdder
            Spacer()
            cardRemover
            
        }
        .font(.largeTitle)
    }
    
    var themeChooseButtons: some View {
        HStack(spacing: 40) {
            chooseTheme1
            chooseTheme2
            chooseTheme3
        }
        
    }
    
    var title: some View {
        VStack {
            Text("Memorize!")
                .font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 48)
                    .weight(.heavy)

                ).foregroundColor(Color.indigo)

            /*if chosenTheme.isEmpty {
                Spacer()
                Text("Choose theme to start!")
                    .font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 34)
                        .weight(.heavy)

                    ).foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)*/
            }
        }
    }

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius:12)
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 5)
                Text(card.content)
                    .font(.system(size: 70))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)

        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
