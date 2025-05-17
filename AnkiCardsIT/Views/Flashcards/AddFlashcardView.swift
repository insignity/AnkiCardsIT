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
    @State private var isLoading = false
    @State private var error: Error?
    
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
            .navigationTitle(isNew ? "New flashcard" : flashcard.front)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await saveFlashcard()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
    
    
    private func saveFlashcard() async {
        isLoading = true
        error = nil
        
        do {
            // Save to SwiftData
            deck.flashcards.append(flashcard)
            context.insert(deck)
            
            // Save to Firebase
            try await FirebaseService.shared.addFlashcard(flashcard, toDeck: deck.id)
            
            dismiss()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}

#Preview {
    AddFlashcardView(flashcard: FlashcardModel(front: "front", back: "back"), deck: DeckModel.sampleData.first!)
}
