//
//  ContentView.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🫨", "🤐", "🤩", "🤯"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundStyle(.cyan)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
