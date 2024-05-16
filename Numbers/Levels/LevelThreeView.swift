import SwiftUI
import AVFoundation

struct LevelThreeView: View {
    @State private var score = 0
    @State private var currentLevel = 0
    @State private var cards: [Card] = []
    @State private var showingAlert = false
    @State private var correctGuesses = 0
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    struct Card: Identifiable {
        let id: Int
        let imageName: String
        var isCorrect: Bool
        var isRevealed: Bool = true
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Select the correct one")
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .foregroundColor(.blue)
            Spacer()
            Text("Step: \(score)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            if(score==10){
                VStack(spacing: 20) {
                    Image("congratulationsBanner")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Congratulations!")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                        .shadow(color: .white, radius: 2, x: 0, y: 2)
                    
                    Text("You've correctly identified all the numbers. Now, you can go back.")
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                }
                .padding()
                .background(Color.green.opacity(0.7))
                .cornerRadius(25)
                .shadow(radius: 15)
                .padding(20)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }else{
                
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
                    currentLevel += 1
                    if currentLevel < 10 {
                        loadLevel(level: currentLevel)
                    } else {
                        
                        currentLevel = 0
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
