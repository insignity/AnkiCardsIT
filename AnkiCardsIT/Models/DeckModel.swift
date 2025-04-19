//
//  DeckModel.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import Foundation
import SwiftData

@Model
class DeckModel {
    var name: String
    var flashcards: [FlashcardModel]
    
    init(name: String, _ flashcards: [FlashcardModel] = []) {
        self.name = name
        self.flashcards = flashcards
    }
    
    
    static let sampleData = [
        DeckModel(name: "My deck", [
            FlashcardModel(front: "I", back: "Я"),
            FlashcardModel(front: "You", back: "Ты"),
            FlashcardModel(front: "We", back: "Мы"),
            FlashcardModel(front: "They", back: "Они")
        ]),
        DeckModel(name: "Empty deck"),
        DeckModel(name: "Intermediate", [
            FlashcardModel(front: "This", back: "Этот"),
            FlashcardModel(front: "That", back: "Тот")]),
        DeckModel(name: "Advanced"),
        DeckModel(name: "Tech"),
    ]
}
