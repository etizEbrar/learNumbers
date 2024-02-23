import SwiftUI
import AVFoundation

struct LevelThreeView: View {
    @State private var score = 0
    @State private var currentLevel = 0
    @State private var cards: [Card] = []
    @State private var showingAlert = false
    @State private var correctGuesses = 0 // Track the number of correct guesses for the current level
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    struct Card: Identifiable {
        let id: Int
        let imageName: String
        var isCorrect: Bool
        var isRevealed: Bool = true
    }
    
    var body: some View {
        VStack {
            Text("Sellect the correct one")
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24) // Adds padding around the text for better spacing
                .foregroundColor(.blue)
            Spacer()
            Text("Step: \(score)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 20)

            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(cards) { card in
                    if card.isRevealed {
                        Image(card.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                            .onTapGesture {
                                cardTapped(card)
                            }
                            .transition(.scale)
                    }
                }
            }

            Spacer()
        }
        .background(showingAlert ? Color.red : Color.white)
        .animation(.easeOut, value: showingAlert)
        .onAppear(perform: setupGame)
    }
    
    func setupGame() {
        loadLevel(level: currentLevel)
    }
    
    func loadLevel(level: Int) {
        cards.removeAll()
        
        let correctCard = Card(id: 1, imageName: "number\(level)_correct", isCorrect: true)
        let wrongCard = Card(id: 2, imageName: "number\(level)_wrong", isCorrect: false)
        
        cards.append(contentsOf: [correctCard, wrongCard])
        while cards.count < 4 {
            cards.append(Card(id: cards.count + 1, imageName: "number\(level)_wrong", isCorrect: false))
        }
        
        cards.shuffle()
        correctGuesses = cards.filter { $0.isCorrect }.count
    }
    
    func cardTapped(_ tappedCard: Card) {
        if let index = cards.firstIndex(where: { $0.id == tappedCard.id }) {
            if cards[index].isCorrect {
                score += 1
                cards[index].isRevealed = false
                correctGuesses -= 1
                if correctGuesses == 0 {
                    // All correct cards have been found, progress to next level
                    currentLevel += 1
                    if currentLevel < 10 { // Assume there are 10 levels, 0-9
                        loadLevel(level: currentLevel)
                    } else {
                        // Game completed, reset or show final score
                        currentLevel = 0 // Reset to the first level
                        loadLevel(level: currentLevel)
                    }
                }
            } else {
                withAnimation {
                    showingAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showingAlert = false
                    }
                }
            }
        }
    }
}

struct LevelThreeView_Previews: PreviewProvider {
    static var previews: some View {
        LevelThreeView()
    }
}
