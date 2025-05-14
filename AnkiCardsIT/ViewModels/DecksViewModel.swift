import Foundation
import SwiftUI
import SwiftData

@MainActor
class DecksViewModel: ObservableObject {
    @Published var decks: [DeckModel] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let firebaseService = FirebaseService.shared
    
    func loadDecks() async {
        isLoading = true
        error = nil
        
        do {
            decks = try await firebaseService.fetchDecks()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func createDeck(_ deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.createDeck(deck)
            await loadDecks() // Reload decks after creating new one
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func updateDeck(_ deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.updateDeck(deck)
            await loadDecks() // Reload decks after update
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func deleteDeck(_ deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.deleteDeck(deck)
            await loadDecks() // Reload decks after deletion
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func addFlashcard(_ flashcard: FlashcardModel, toDeck deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.addFlashcard(flashcard, toDeck: deck.id.uuidString)
            await loadDecks() // Reload decks after adding flashcard
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func updateFlashcard(_ flashcard: FlashcardModel, inDeck deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.updateFlashcard(flashcard, inDeck: deck.id.uuidString)
            await loadDecks() // Reload decks after updating flashcard
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func deleteFlashcard(_ flashcard: FlashcardModel, fromDeck deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.deleteFlashcard(flashcard, fromDeck: deck.id.uuidString)
            await loadDecks() // Reload decks after deleting flashcard
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
} 