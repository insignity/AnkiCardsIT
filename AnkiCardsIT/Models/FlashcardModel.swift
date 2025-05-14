//
//  FlashCardModel.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import Foundation
import SwiftData
import FirebaseCore
import FirebaseFirestore

@Model
final class FlashcardModel {
    var id: UUID
    var front: String
    var back: String
    var answers: [Bool]
    var createdAt: Date
    var updatedAt: Date?
    
    //TODO: THINK ABOUT OUT OF PROGRESS PROPERTY
    
    init(front: String = "", back: String = "", _ answers: [Bool] = []) {
        self.id = UUID()
        self.front = front
        self.back = back
        self.answers = answers
        self.createdAt = Date()
    }
    
    // Convert to Firestore data
    public func toFirestoreData() -> [String: Any] {
        return [
            "id": id.uuidString,
            "front": front,
            "back": back,
            "answers": answers,
            "createdAt": createdAt,
            "updatedAt": updatedAt ?? Date()
        ]
    }
    
    // Create from Firestore data
    public static func fromFirestoreData(_ data: [String: Any]) -> FlashcardModel {
        let flashcard = FlashcardModel(
            front: data["front"] as? String ?? "",
            back: data["back"] as? String ?? "",
            data["answers"] as? [Bool] ?? []
        )
        flashcard.createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
        flashcard.updatedAt = (data["updatedAt"] as? Timestamp)?.dateValue()
        return flashcard
    }
}

// Progress I want to see how many attempts of current word and how many was correct,
//
