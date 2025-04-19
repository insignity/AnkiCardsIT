//
//  AnkiCardsITApp.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 18.03.2025.
//

import SwiftUI

@main
struct AnkiCardsITApp: App {
    var body: some Scene {
        WindowGroup {
            DecksView().modelContainer(for: [DeckModel.self])
        }
    }
}
