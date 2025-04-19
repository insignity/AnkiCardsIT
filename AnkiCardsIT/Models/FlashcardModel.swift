//
//  FlashCardModel.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import Foundation
import SwiftData

@Model
class FlashcardModel {
    var front: String
    var back: String
    var progress: Int
    
    //var belongsTo: DeckModel if it doesn't work
    
    //TODO: THINK ABOUT OUT OF PROGRESS PROPERTY
    
    init(front: String = "", back: String = "", _ progress: Int = 0) {
        self.front = front
        self.back = back
        self.progress = progress
    }
}
