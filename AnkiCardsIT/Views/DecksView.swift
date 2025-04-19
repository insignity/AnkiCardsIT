//
//  DecksView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import SwiftUI
import SwiftData

struct DecksView: View {
    @Query(sort: \DeckModel.name) private var decks: [DeckModel]
    @Environment(\.modelContext) private var context
    @State private var newDeck: DeckModel?
    
    init() {
        _decks = Query(sort: \DeckModel.name)
    }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(decks){deck in
                    NavigationLink{
                        FlashCardsView(deck: deck)
                    } label: {
                        DeckView(deck: deck)
                    }
                }
                .onDelete(perform: deleteDecks(indexes:))
            }
            .navigationTitle("Decks")
            .toolbar {
                ToolbarItem {
                    Button("Add Deck", action: {
                        newDeck = DeckModel(name: "")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .sheet(item: $newDeck){ deck in
                NavigationStack {
                    AddDeckView(deck: deck, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        }
    }
    
    private func deleteDecks(indexes: IndexSet) {
        for index in indexes {
            context.delete(decks[index])
        }
    }
}

#Preview {
    DecksView()
        .modelContainer(SampleData.shared.modelContainer)
}
