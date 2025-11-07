//
//  ContentView.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 01/11/2025.
//

import SwiftUI

struct ContentView: View {

    @State var currentTheme : Theme
    @State var cardCount : Int
    
    let themes = [
        Theme(name: "Activities", emojis: ["⚽️", "🏀", "⚽️", "🏀", "🎱", "🎾", "🎱", "🎾", "🥏", "🏓", "🥏", "🏓", "🪀", "🎯", "🪀", "🎯", "🥊", "🥊"], symbol: "sportscourt", color: .green),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐶", "🐱", "🐰", "🦊", "🐰", "🦊", "🐷", "🐷"], symbol: "pawprint", color: .blue),
        Theme(name: "Faces", emojis: ["🫨", "🤐", "🫨", "🤐", "🙃", "😎", "🙃", "😎", "🥶", "🤢", "🥶", "🤢"], symbol: "face.smiling", color: .red)
    ]
    
    init() {
        self.cardCount = themes[0].emojis.count
        self.currentTheme = themes[0]
    }

    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChangers
        }
        .padding()
    }

    
    var themeChangers: some View {
        HStack {
            ForEach(themes, id: \.name) { theme in
                Button(action: {
                    changeTheme(to: theme)
                }, label: {
                    VStack {
                        Image(systemName: theme.symbol)
                            .imageScale(.large)
                        Text(theme.name)
                            .font(.subheadline)
                    }
                })
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
            ForEach(0..<currentTheme.emojis.count, id: \.self) { index in
                CardView(content: currentTheme.emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(currentTheme.color)
    }

    
    func changeTheme(to theme: Theme) {
        currentTheme.emojis = theme.emojis.shuffled()
        currentTheme.color = theme.color
        if cardCount > currentTheme.emojis.count {
            cardCount = currentTheme.emojis.count
        } else {
            cardCount = currentTheme.emojis.count
        }
    }
    
    func flipRandomPairOfCards() {
        
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct Theme {
    let name: String
    var emojis: [String]
    let symbol: String
    var color: Color
}

#Preview {
    ContentView()
}
