//
//  FlashCardsView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 15.04.2025.
//

import SwiftUI
import SwiftData

struct FlashCardsView: View {
    @Bindable private var deck: DeckModel
    @State var newFlashcard: FlashcardModel?
    
    init(deck: DeckModel) {
        self.deck = deck
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(deck.flashcards, id: \.self){ card in
                        VStack(alignment: .leading) {
                            Text(card.front)
                                .font(.headline)
                            Text(card.back)
                                .font(.subheadline)
                        }
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                    }){
                        Text("Study")
                    }
                    .frame(width: 200, height: 45)
                    .background(Color.blue.secondary)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button(action: {
                        newFlashcard = FlashcardModel()
                    }){
                        Text("+")
                            .font(.title)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.accentColor.opacity(0.5))
                    .cornerRadius(100)
                    
                    Spacer()
                }
            }
        }
        .navigationTitle(deck.name)
        
        .sheet(item: $newFlashcard){ flashcard in
            NavigationStack {
                AddFlashcardView(flashcard: flashcard, deck: deck)
            }
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    FlashCardsView(deck: SampleData.shared.deck)
}
