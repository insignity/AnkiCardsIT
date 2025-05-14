//
//  StudyView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 18.04.2025.
//

import SwiftUI

struct StudyModeView: View {
    @Binding var path: NavigationPath
    var deck: DeckModel
    @State private var didSeeAnswer = false
    @State var flashcard: FlashcardModel
    @State var isFlipped = false
    @State var index = 0
    
    init(deck: DeckModel, path: Binding<NavigationPath>) {
        self.deck = deck
        self.flashcard = deck.flashcards.first ?? FlashcardModel(front: "front", back: "back")
        self._path = path
    }
    
    func next(isCorrect: Bool){
        flashcard.answers.append(isCorrect)
        
        if(deck.flashcards.count > index + 1){
            index = index + 1
            flashcard = deck.flashcards[index]
            didSeeAnswer = false
            isFlipped = false
        }else{
            path.append(Screen.results(deck: deck))
        }
    }
    
    var body: some View {
        VStack{
            StudyModeFlashcardView(flashcard: flashcard, didSeeAnswer: $didSeeAnswer, isFlipped: $isFlipped)
            
            Text("Do you know the word?")
            
            Button(action: {
                next(isCorrect: true)
            }, label: {
                RoundedRectangle(cornerRadius: 12)
                .frame(width: 200, height: 50)
                .overlay(Text("Yes")
                    .foregroundColor(.white))
            })
            .disabled(didSeeAnswer)
            
            Button(action: {
                next(isCorrect: false)
            }, label: {
                Text("No")
            })
        }
        .navigationTitle("Study mode")
    }
}

#Preview {
    NavigationStack {
        StudyModeView(deck: DeckModel.sampleData.first!, path: .constant(NavigationPath()))
    }
}
