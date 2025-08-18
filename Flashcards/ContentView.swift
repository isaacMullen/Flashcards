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
    
    private let placeholderDecks = ["Math", "History", "Science"]

    @State private var currentIndex = 0
    @State private var isFlipped = false
    @State private var showDeckMenu = false
    @State private var selectedDeck = "Default Deck"

    var body: some View {
        ZStack {
            // Full-screen swipe & tap detection
            Color.white
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            let verticalAmount = value.translation.height
                            
                            if verticalAmount < -50 {
                                nextCard()
                            } else if verticalAmount > 50 {
                                nextCard()
                            }
                        }
                )
                .onTapGesture {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
            
            VStack {
                // Hamburger menu + Top Text
                ZStack {
                    HStack {
                        Button(action: { showDeckMenu.toggle() }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()
                    }
                    
                    Text(isFlipped ? "Answer" : "Question")
                        .font(.system(size: 21))
                }
                
                

                // Card text (no gesture here, so it doesn't block the background one)
                Text(isFlipped ? cards[currentIndex].back : cards[currentIndex].front)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            // Deck menu
            if showDeckMenu {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(placeholderDecks, id: \.self) { deck in
                        Button(deck) {
                            selectedDeck = deck
                            showDeckMenu = false
                            print("Selected deck: \(deck)")
                        }
                        .padding(5)
                        .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.gray)
                .frame(maxWidth: 200, alignment: .leading)
                .position(x: 105, y: 115)
            }
        }
    }
    
    private func nextCard() {
        withAnimation {
            isFlipped = false
            currentIndex = (currentIndex + 1) % cards.count
        }
    }
}

#Preview {
    ContentView()
}
