//
//  DeckModel.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import Foundation
import SwiftData
import FirebaseCore
import FirebaseFirestore

@Model
final class DeckModel {
    var id: String
    var name: String
    @Relationship(deleteRule: .cascade) var flashcards: [FlashcardModel]
    
    init(name: String, _ flashcards: [FlashcardModel] = [], id: String = "") {
        self.id = id.isEmpty ?  UUID().uuidString : id
        self.name = name
        self.flashcards = flashcards
    }
    
    // Convert to Firestore data
    public func toFirestoreData() -> [String: Any] {
        return [
            "id": id,
            "name": name,
        ]
    }
    
    // Create from Firestore data
    public static func fromFirestoreData(_ data: [String: Any]) -> DeckModel {
        let deck = DeckModel(
            name: data["name"] as? String ?? "",
            id: data["id"] as? String ?? UUID().uuidString
        )
        return deck
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
