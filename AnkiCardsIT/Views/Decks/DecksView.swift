import SwiftUI
import SwiftData

struct DecksView: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = DeckViewModel()
    @State private var showingAddDeck = false
    @State private var newDeckName = ""
    
    var body: some View {
        List {
            ForEach(viewModel.decks) { deck in
                NavigationLink(value: Screen.flashcards(deck: deck)) {
                    VStack(alignment: .leading) {
                        Text(deck.name)
                            .font(.headline)
                        Text("\(deck.flashcards.count) cards")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        Task {
                            await viewModel.deleteDeck(deck)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("Decks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddDeck = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .alert("New Deck", isPresented: $showingAddDeck) {
            TextField("Deck Name", text: $newDeckName)
            Button("Cancel", role: .cancel) {
                newDeckName = ""
            }
            Button("Create") {
                let newDeck = DeckModel(name: newDeckName)
                Task {
                    await viewModel.saveDeck(newDeck)
                }
                newDeckName = ""
            }
        }
        .task {
            await viewModel.fetchDecks()
        }
        .refreshable {
            await viewModel.fetchDecks()
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK") {
                viewModel.error = nil
            }
        } message: {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        }
    }
} 