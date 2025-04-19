//
//  AddDeckView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 11.04.2025.
//

import SwiftUI
import SwiftData

struct AddDeckView: View {
    //MARK: Navigation dismiss
    @Environment(\.dismiss) private var dismiss
    
    //MARK: Swift Data
    @Environment(\.modelContext) private var context
    @Query(sort: \DeckModel.name) private var decks: [DeckModel]
    
    @Bindable var deck: DeckModel
    
    let isNew: Bool
    
    init(deck: DeckModel, isNew: Bool = false) {
        self.deck = deck
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Deck name", text: $deck.name)
                .autocorrectionDisabled()
        }
        .navigationTitle(isNew ? "New deck" : "Deck")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        context.insert(deck)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(deck)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        AddDeckView(deck: DeckModel(name: ""))
    }
}
