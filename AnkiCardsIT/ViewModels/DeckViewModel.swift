import Foundation
import SwiftUI
import FirebaseFirestore
import SwiftData

@MainActor
class DeckViewModel: ObservableObject {
    @Published var decks: [DeckModel] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let firebaseService = FirebaseService.shared
    
    func saveDeck(_ deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            try await firebaseService.createDeck(deck)
            await fetchDecks()
        } catch {
            self.error = error
            print("Error saving deck: \(error)")
        }
        
        isLoading = false
    }
    
    func fetchDecks() async {
        isLoading = true
        error = nil
        
        do {
            decks = try await firebaseService.fetchDecks()
        } catch {
            self.error = error
            print("Error fetching decks: \(error)")
        }
        
        isLoading = false
    }
    
    func deleteDeck(_ deck: DeckModel) async {
        isLoading = true
        error = nil
        
        do {
            print("a")
            try await firebaseService.deleteDeck(deck)
            print("b")
            await fetchDecks()
            print("c")
        } catch {
            self.error = error
            print("Error deleting deck: \(error)")
        }
        
        isLoading = false
    }
} 
