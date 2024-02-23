import SwiftUI
import AVFoundation

struct LevelOneView: View {
    let numberImages = [
        "number0_correct", "number1_correct", "number2_correct",
        "number3_correct", "number4_correct", "number5_correct",
        "number6_correct", "number7_correct", "number8_correct",
        "number9_correct"
    ]
    let numberAudioFiles = [
        "Yeni Kayıt 11", "Yeni Kayıt 12", "Yeni Kayıt 13",
        "Yeni Kayıt 14", "Yeni Kayıt 15", "Yeni Kayıt 16",
        "Yeni Kayıt 17", "Yeni Kayıt 18", "Yeni Kayıt 19",
        "Yeni Kayıt 20"
    ]
    @State private var isSoundEnabled = true
    @State private var audioPlayer: AVAudioPlayer?
    @State private var path: [Int] = []
    
    var body: some View {
        NavigationStack(path: $path) {            ScrollView {
                VStack(spacing: 20) {
                    Text("Tap on the numbers to hear their sounds.")
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24) // Adds padding around the text for better spacing
                        .foregroundColor(.blue)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<9, id: \.self) { index in
                            imageButton(for: index)
                        }
                    }

                    imageButton(for: 9)
                        .padding(.top, 10) // Adjust the top padding for the 9th button

                    Spacer(minLength: 50) // Adds extra space at the bottom if needed
                }
                .padding(.top, 20) // Adds padding at the top of the VStack
            }
            .navigationBarItems(trailing: Button(action: toggleSound) {
                Image(systemName: isSoundEnabled ? "speaker.2.fill" : "speaker.slash.fill")
                    .foregroundColor(Color(red: 0.95, green: 0.36, blue: 0.36))
            })
            .onAppear {
                configureAudioSession()
            }
        }
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
                if isSoundEnabled {
                    playSound(for: number)
                }
            }
    }

    func toggleSound() {
        isSoundEnabled.toggle()
    }

    func playSound(for number: Int) {
        let audioFileName = numberAudioFiles[number]
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "m4a") else {
            print("Audio file not found: \(audioFileName)")
            return
        }

        do {
            audioPlayer?.stop()
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Audio playback error: \(error.localizedDescription)")
        }
    }

    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
}

struct LevelOneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelOneView()
    }
}
