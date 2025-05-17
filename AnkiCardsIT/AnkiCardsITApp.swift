//
//  AnkiCardsITApp.swift
//  AnkiCardsIT
//
//  Created by Aiarsien on 18.03.2025.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct AnkiCardsITApp: App {
    @State private var path = NavigationPath()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                DecksView(path: $path)
                    .navigationDestination(for: Screen.self) { screen in
                        switch screen {
                        case .flashcards(let deck):
                            FlashCardsView(deck: deck, path: $path)
                                .navigationTitle(deck.name)
                        case .study(let deck):
                            StudyModeView(deck: deck, path: $path)
                                .navigationTitle("Study Mode")
                        case .results(let deck):
                            StudyModeResultsView(deck: deck, path: $path)
                                .navigationTitle("Results")
                        }
                    }
            }
            .modelContainer(for: [DeckModel.self, FlashcardModel.self]) { result in
                
            }
        }
    }
}

enum Screen: Hashable {
    case flashcards(deck: DeckModel)
    case study(deck: DeckModel)
    case results(deck: DeckModel)
}
