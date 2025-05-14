//
//  DeckView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import SwiftUI

struct DeckTileView: View {
    var deck: DeckModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(deck.name)
                .font(.headline)
            Text("Cards count: \(deck.flashcards.count)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(height: 50)
        .contentShape(Rectangle())
    }
}

#Preview {
    List {
        DeckTileView(deck: DeckModel.sampleData.first!)
        DeckTileView(deck: DeckModel.sampleData[1])
    }
}
