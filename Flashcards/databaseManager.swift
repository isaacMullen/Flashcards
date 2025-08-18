//
//  databaseManager.swift
//  Flashcards
//
//  Created by Mike Mullen on 2025-08-14.
//
import SQLite3
import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()
    var db: OpaquePointer?
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func openDatabase() {
        let dbPath = getDocumentsDirectory().appendingPathComponent("Flashcards.sqlite").path
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("ERROR OPENING DATABASE")
        } else {
            // Enable foreign keys immediately after opening DB (disallows creating a card without having a valid deck to insert into)
            print("Database path: \(dbPath)")
            sqlite3_exec(db, "PRAGMA foreign_keys = ON;", nil, nil, nil)
        }
    }
}
