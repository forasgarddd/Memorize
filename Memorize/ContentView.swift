//
//  ContentView.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 06/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount: Int = 0
    
    @State var chosenTheme: Array<String> = []
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            //cardCountAdjusters
            themeChooseButtons
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
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<chosenTheme.count, id: \.self) { index in
                CardView(content: chosenTheme[index])
                    .aspectRatio(2/3, contentMode: .fit)
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

            if chosenTheme.isEmpty {
                Spacer()
                Text("Choose theme to start!")
                    .font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 34)
                        .weight(.heavy)

                    ).foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
            }
        }

        
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius:12)
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)

        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
