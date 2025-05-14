import Foundation
import SwiftData

class InitialDeckService {
    static let initialDeckName = "Getting Started"
    
    static func createInitialDeck(modelContext: ModelContext) {
        // Check if initial deck already exists
        let descriptor = FetchDescriptor<DeckModel>(
            predicate: #Predicate<DeckModel> { deck in
                deck.name == initialDeckName
            }
        )
        
        do {
            let existingDecks = try modelContext.fetch(descriptor)
            if !existingDecks.isEmpty {
                return // Initial deck already exists
            }
            
            // Create initial deck with basic flashcards
            let initialDeck = DeckModel(name: initialDeckName, [
                FlashcardModel(front: "Welcome to AnkiCards!", back: "Swipe right to mark as correct, left for incorrect"),
                FlashcardModel(front: "How to study", back: "Tap on a deck to start studying. Use the study mode for spaced repetition"),
                FlashcardModel(front: "Creating cards", back: "Tap the + button to add new cards to your deck"),
                FlashcardModel(front: "Managing decks", back: "Long press on a deck to edit or delete it"),
                FlashcardModel(front: "Progress tracking", back: "View your study results after each session")
            ])
            
            modelContext.insert(initialDeck)
            try modelContext.save()
        } catch {
            print("Error creating initial deck: \(error)")
        }
    }
} 