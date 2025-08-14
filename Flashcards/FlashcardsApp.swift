//
//  FlashcardsApp.swift
//  Flashcards
//
//  Created by Mike Mullen on 2025-08-14.
//

import SwiftUI

@main
struct FlashcardsApp: App {

    // Initialize the database when the app starts
    init() {
        _ = DatabaseManager.shared
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
