import Foundation
import FirebaseFirestore
import FirebaseCore
import SwiftData

class FirebaseService {
    static let shared = FirebaseService()
    private let db = Firestore.firestore()
    
    // MARK: - Deck Operations
    
    func createDeck(_ deck: DeckModel) async throws {
        let deckData = deck.toFirestoreData()
        let deckRef = try await db.collection("decks").addDocument(data: deckData)
        
        // Save flashcards
        for flashcard in deck.flashcards {
            var flashcardData = flashcard.toFirestoreData()
            flashcardData["deckId"] = deckRef.documentID
            try await deckRef.collection("flashcards").addDocument(data: flashcardData)
        }
    }
    
    func fetchDecks() async throws -> [DeckModel] {
        let snapshot = try await db.collection("decks").getDocuments()
        var decks: [DeckModel] = []
        
        for document in snapshot.documents {
            let deckData = document.data()
            let deck = DeckModel.fromFirestoreData(deckData)
            
            // Fetch flashcards for this deck
            let flashcardsSnapshot = try await document.reference.collection("flashcards").getDocuments()
            var flashcards: [FlashcardModel] = []
            
            for flashcardDoc in flashcardsSnapshot.documents {
                let flashcardData = flashcardDoc.data()
                let flashcard = FlashcardModel.fromFirestoreData(flashcardData)
                flashcards.append(flashcard)
            }
            
            deck.flashcards = flashcards
            decks.append(deck)
        }
        
        return decks
    }
    
    func updateDeck(_ deck: DeckModel) async throws {
        let deckId = deck.id.uuidString
        let deckData = deck.toFirestoreData()
        try await db.collection("decks").document(deckId).updateData(deckData)
        
        // Update flashcards
        for flashcard in deck.flashcards {
            let flashcardId = flashcard.id.uuidString
            let flashcardData = flashcard.toFirestoreData()
            try await db.collection("decks").document(deckId)
                .collection("flashcards").document(flashcardId)
                .updateData(flashcardData)
        }
    }
    
    func deleteDeck(_ deck: DeckModel) async throws {
        let deckId = deck.id.uuidString
        
        // Delete all flashcards in the deck
        let flashcardsSnapshot = try await db.collection("decks").document(deckId)
            .collection("flashcards").getDocuments()
        
        for document in flashcardsSnapshot.documents {
            try await document.reference.delete()
        }
        
        // Delete the deck
        try await db.collection("decks").document(deckId).delete()
    }
    
    // MARK: - Flashcard Operations
    
    func addFlashcard(_ flashcard: FlashcardModel, toDeck deckId: String) async throws {
        var flashcardData = flashcard.toFirestoreData()
        flashcardData["deckId"] = deckId
        
        try await db.collection("decks").document(deckId)
            .collection("flashcards").addDocument(data: flashcardData)
    }
    
    func updateFlashcard(_ flashcard: FlashcardModel, inDeck deckId: String) async throws {
        let flashcardId = flashcard.id.uuidString
        let flashcardData = flashcard.toFirestoreData()
        
        try await db.collection("decks").document(deckId)
            .collection("flashcards").document(flashcardId)
            .updateData(flashcardData)
    }
    
    func deleteFlashcard(_ flashcard: FlashcardModel, fromDeck deckId: String) async throws {
        let flashcardId = flashcard.id.uuidString
        
        try await db.collection("decks").document(deckId)
            .collection("flashcards").document(flashcardId)
            .delete()
    }
} 
