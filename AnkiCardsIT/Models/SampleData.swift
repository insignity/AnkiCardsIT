//
//  SampleData.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 08.04.2025.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var deck: DeckModel{
        DeckModel.sampleData.first!
    }
    
    private init(){
        let schema = Schema([
            DeckModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do{
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer \(error)")
        }
    }
    
    private func insertSampleData(){
        for deck in DeckModel.sampleData {
            context.insert(deck)
        }
    }
}
