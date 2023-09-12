//
//  ContentView.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 06/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView(isFaceUp: true)
        }
        
        .foregroundColor(.green)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius:12)
            if isFaceUp {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text("💀").font(.largeTitle)
            } else {
                base.fill()
            }
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
