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
    
    private init() {
        openDatabase()
        createTables()
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func openDatabase() {
        let dbPath = getDocumentsDirectory().appendingPathComponent("Flashcards.sqlite").path
        
        print("Database path: \(dbPath)")
        
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("ERROR OPENING DATABASE")
        }
    }
    
    private func createTables() {
        let createDecksTable = """
        CREATE TABLE IF NOT EXISTS Decks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
            );
        """
        
        let createCardsTable = """
        CREATE TABLE IF NOT EXISTS Cards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            deck_id INTEGER NOT NULL,
            front TEXT NOT NULL,
            back TEXT NOT NULL,
            FOREIGN KEY (deck_id) REFERENCES Decks(id)
            );
        """

        
        sqlite3_exec(db, createDecksTable, nil, nil, nil)
        sqlite3_exec(db, createCardsTable, nil, nil, nil)
    }
}
