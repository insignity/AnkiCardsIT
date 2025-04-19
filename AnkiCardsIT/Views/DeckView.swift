//
//  DeckView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import SwiftUI

struct DeckView: View {
    var deck: DeckModel
    
    init(deck: DeckModel) {
        self.deck = deck
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(deck.name).font(.headline)
                
            Text("Cards count: \(deck.flashcards.count)").fontWeight(.light)
            
        }
        .frame(height: 50)
        .cornerRadius(10)
    }
}

#Preview {
    DeckView(deck: DeckModel(name: "My new deck", [FlashcardModel(front: "Hi", back: "Привет")]))
}
