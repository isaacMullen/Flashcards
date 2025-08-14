//
//  ContentView.swift
//  Flashcards
//
//  Created by Mike Mullen on 2025-08-14.
//

import SwiftUI

struct Card {
    let front: String
    let back: String
}

struct ContentView: View {
    private let cards: [Card] = [
        Card(front: "What is the capital of France?", back: "Paris"),
        Card(front: "2 + 2", back: "4"),
        Card(front: "Largest planet in our solar system?", back: "Jupiter")
    ]
    
    @State private var currentIndex = 0
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            // Background color for the card
            Color.white.ignoresSafeArea() // Fill entire screen

            VStack {
                Spacer()

                // Card text
                Text(isFlipped ? cards[currentIndex].back : cards[currentIndex].front)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                // Next button
                Button("Next Card") {
                    withAnimation {
                        isFlipped = false
                        currentIndex = (currentIndex + 1) % cards.count
                    }
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.bottom, 40) // Keep away from edge
            }
            .padding()
        }
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
