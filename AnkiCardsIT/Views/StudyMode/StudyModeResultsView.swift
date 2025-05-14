//
//  StudyModeResultsView.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 24.04.2025.
//

import SwiftUI

struct StudyModeResultsView: View {
    @Binding var path: NavigationPath
    var deck: DeckModel
    var correctAnswers = 0
    var totalAnswers = 0
    
    init(deck: DeckModel, path: Binding<NavigationPath>) {
        self.deck = deck
        self._path = path
        
        calculateAnswers()
    }
    
    mutating func calculateAnswers(){
        for card in deck.flashcards{
            totalAnswers += 1
            if(card.answers.last == true){
                correctAnswers += 1
            }
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Total answers:")
                    .font(.headline)
                Text("\(totalAnswers)")
                    .font(.headline)
            }
            HStack{
                Text("Correct answers:")
                    .font(.headline)
                Text("\(correctAnswers)")
                    .font(.headline)
            }
            Button(action: {
                path.removeLast() // Go back to study view
                path.removeLast() // Go back to flashcards view
                path.removeLast() // Go back to home view
            }){
                Text("Ok")
            }
        }
        .navigationTitle("Results")
    }
}
