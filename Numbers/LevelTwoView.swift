import SwiftUI
import AVFoundation

struct LevelTwoView: View {
    let numberImages = [
        "number0_correct", "number1_correct", "number2_correct",
        "number3_correct", "number4_correct", "number5_correct",
        "number6_correct", "number7_correct", "number8_correct",
        "number9_correct"
    ]

    @State private var correctNumberToFind = Int.random(in: 0...9)
    @State private var score = 0
    @State private var isSoundEnabled = true
    @State private var audioPlayer: AVAudioPlayer?
    @State private var applausePlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            Spacer()

            Text("Score: \(score)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 20)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(0..<9, id: \.self) { index in
                    imageButton(for: index)
                }
                Spacer().frame(height: 100) // Sol boşluk
                imageButton(for: 9) // 9 numarası
                Spacer().frame(height: 100) // Sağ boşluk
            }

            Spacer()
        }
        .navigationBarItems(trailing: Button(action: toggleSound) {
            Image(systemName: isSoundEnabled ? "speaker.2.fill" : "speaker.slash.fill")
                .foregroundColor(Color(red: 0.95, green: 0.36, blue: 0.36))
        })
        .onAppear(perform: startGame)
    }

    func imageButton(for number: Int) -> some View {
        Image(numberImages[number])
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 2)
            .onTapGesture {
                imageTapped(number)
            }
    }

    func startGame() {
        score = 0
        pickNewNumber()
    }

    func toggleSound() {
        isSoundEnabled.toggle()
        if isSoundEnabled {
            playSound(for: correctNumberToFind)
        }
    }

    func imageTapped(_ number: Int) {
        if number == correctNumberToFind {
            score += 1
            playApplauseSound()
        } else {
            playSound(for: correctNumberToFind)
        }
    }

    func playSound(for number: Int) {
        guard isSoundEnabled, let url = Bundle.main.url(forResource: "\(number)", withExtension: "m4a") else { return }
        DispatchQueue.global().async {
            self.audioPlayer?.stop()
            self.audioPlayer = try? AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.prepareToPlay()
            DispatchQueue.main.async {
                self.audioPlayer?.play()
            }
        }
    }

    func playApplauseSound() {
        guard isSoundEnabled, let applauseURL = Bundle.main.url(forResource: "alkiss", withExtension: "mp3") else { return }
        DispatchQueue.global().async {
            self.applausePlayer?.stop()
            self.applausePlayer = try? AVAudioPlayer(contentsOf: applauseURL)
            self.applausePlayer?.prepareToPlay()
            DispatchQueue.main.async {
                self.applausePlayer?.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.pickNewNumber()
                }
            }
        }
    }

    func pickNewNumber() {
        correctNumberToFind = Int.random(in: 0...9)
        playSound(for: correctNumberToFind)
    }
}

struct LevelTwoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LevelTwoView()
        }
    }
}
