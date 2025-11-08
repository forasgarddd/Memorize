//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ivan Devitskyi on 01/11/2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
