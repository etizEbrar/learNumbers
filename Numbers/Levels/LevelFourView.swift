import SwiftUI

struct LevelFourView: View {
    let brightBlue = Color(red: 0.22, green: 0.44, blue: 0.87)
    let softRed = Color(red: 0.95, green: 0.36, blue: 0.36)
    let vibrantYellow = Color(red: 1.00, green: 0.84, blue: 0.25)
    let lightGreen = Color(red: 0.48, green: 0.78, blue: 0.46)
    
    @State private var currentImageNumber: Int = Int.random(in: 1...9)
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        ZStack {
            vibrantYellow.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("What's the count?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(brightBlue)
                    
                    Text("Correct Answers: \(score)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(lightGreen)
                    
                    Image("\(currentImageNumber)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                    
                    TextField("Enter your answer here...", text: $userAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(height: 60)
                        .font(.title)
                        .padding(.horizontal, 20)
                    
                    Button("Submit") {
                        checkAnswer()
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(softRed)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.horizontal, 50)
                }
                .padding(.bottom, 20)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: nil, dismissButton: .default(Text("OK"), action: {
                self.loadNewImage()
            }))
        }
    }
    
    func checkAnswer() {
        if let answer = Int(userAnswer), answer == currentImageNumber {
            score += 1
            alertTitle = "Correct!"
        } else {
            alertTitle = "Oops! The correct answer was \(currentImageNumber)."
        }
        showAlert = true
        userAnswer = ""
    }
    
    func loadNewImage() {
        var newImageNumber: Int
        repeat {
            newImageNumber = Int.random(in: 1...9)
        } while newImageNumber == currentImageNumber
        currentImageNumber = newImageNumber
    }
}

struct LevelFourView_Previews: PreviewProvider {
    static var previews: some View {
        LevelFourView()
    }
}
