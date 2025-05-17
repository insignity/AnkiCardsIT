import Foundation
import FirebaseCore
import FirebaseDatabase
import SwiftData

class FirebaseService {
    static let shared = FirebaseService()
    private let db = Database.database().reference()
    
    // MARK: - Deck Operations
    func createDeck(_ deck: DeckModel) async throws {
        let deckData = deck.toFirestoreData()
        let deckRef = db.child("decks").child(deck.id)
        try await deckRef.setValue(deckData)
        
        // Save flashcards
        for flashcard in deck.flashcards {
            var flashcardData = flashcard.toFirestoreData()
            flashcardData["deckId"] = deck.id
            try await deckRef.child("flashcards").child(flashcard.id.uuidString).setValue(flashcardData)
        }
    }
    
    func fetchDecks() async throws -> [DeckModel] {
        let snapshot = try await db.child("decks").getData()
        var decks: [DeckModel] = []
        
        guard let decksDict = snapshot.value as? [String: [String: Any]] else {
            return []
        }
        
        for (_, deckData) in decksDict {
            let deck = DeckModel.fromFirestoreData(deckData)
            
            // Fetch flashcards for this deck
            if let flashcardsDict = deckData["flashcards"] as? [String: [String: Any]] {
                var flashcards: [FlashcardModel] = []
                
                for (_, flashcardData) in flashcardsDict {
                    let flashcard = FlashcardModel.fromFirestoreData(flashcardData)
                    flashcards.append(flashcard)
                }
                
                deck.flashcards = flashcards
            }
            
            decks.append(deck)
        }
        
        return decks
    }
    
    func deleteDeck(_ deck: DeckModel) async throws {
        let deckId = deck.id
        do {
            print(deckId);
            try await db.child("decks").child(deckId).removeValue()
        } catch {
            print("Error: \(error)")
        }
    }
    
    // MARK: - Flashcard Operations
    
    func addFlashcard(_ flashcard: FlashcardModel, toDeck deckId: String) async throws {
        var flashcardData = flashcard.toFirestoreData()
        flashcardData["deckId"] = deckId
        
        try await db.child("decks").child(deckId)
            .child("flashcards").child(flashcard.id.uuidString)
            .setValue(flashcardData)
    }
    
    func deleteFlashcard(_ flashcard: FlashcardModel, fromDeck deckId: String) async throws {
        let flashcardId = flashcard.id.uuidString
        print(flashcardId)
        do {
            try await db.child("decks").child(deckId)
                .child("flashcards").child(flashcardId)
                .removeValue()
               print("Deck successfully deleted!")
           } catch {
               print("Error deleting deck: \(error)") // Check if you see any errors here!
           }
    }
}
