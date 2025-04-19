//
//  AddFlashCardView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 17.04.2025.
//

import SwiftUI
import SwiftData

struct AddFlashcardView: View {
    
    //MARK: Navigation dismiss
    @Environment(\.dismiss) private var dismiss
    
    //MARK: Swift Data
    @Environment(\.modelContext) private var context
    @Query(sort: \FlashcardModel.front) private var flashcards: [FlashcardModel]
    
    @Bindable var flashcard: FlashcardModel
    
    let isNew: Bool
    
    @Bindable var deck: DeckModel
    
    init(flashcard: FlashcardModel, isNew: Bool = false, deck: DeckModel) {
        self.flashcard = flashcard
        self.isNew = isNew
        self.deck = deck
    }
    
    
    var body: some View {
            Form {
                TextField("Front", text: $flashcard.front)
                    .autocorrectionDisabled()
                TextField("Back", text: $flashcard.back)
                    .autocorrectionDisabled()
            }
            .navigationTitle(isNew ? "New flashcard" : "Deck")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
//                        context.insert(flashcard)
                        deck.flashcards.append(flashcard)
                        context.insert(deck)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
//    AddFlashcardView(flashcard: FlashcardModel(front: "", back: "", deck: SampleData.shared.deck))
}
