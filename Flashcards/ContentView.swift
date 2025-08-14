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
            Color.white
                .ignoresSafeArea()
                .contentShape(Rectangle()) // Makes the entire area tappable/swipeable
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            let verticalAmount = value.translation.height
                            
                            if verticalAmount < -50 {
                                // Swipe up
                                nextCard()
                            } else if verticalAmount > 50 {
                                // Swipe down
                                nextCard()
                            }
                        }
                )
            
            VStack {
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

                Spacer()

                Text(isFlipped ? cards[currentIndex].back : cards[currentIndex].front)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()
            }

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
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
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
