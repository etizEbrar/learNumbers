import SwiftUI
import AVFoundation

struct LevelOneView: View {
    @Binding var isDone:Bool
    let numberImages = [
        "number0_correct", "number1_correct", "number2_correct",
        "number3_correct", "number4_correct", "number5_correct",
        "number6_correct", "number7_correct", "number8_correct",
        "number9_correct"
    ]
    let numberAudioFiles = [
        "Record 0", "Record 1", "Record 2", "Record 3",
        "Record 4", "Record 5", "Record 6",
        "Record 7", "Record 8", "Record 9"
    ]
    @State private var isSoundEnabled = true
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Tap on the numbers to hear their sounds.")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .foregroundColor(.blue)
                
                Spacer(minLength: 18)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<9, id: \.self) { index in
                        imageButton(for: index)
                    }
                }
                
                imageButton(for: 9)
                    .padding(.top, 10)
                Spacer(minLength: 20)                 }
            .padding(.top, 20) 
        }
        .navigationBarItems(trailing: Button(action: toggleSound) {
            Image(systemName: isSoundEnabled ? "speaker.2.fill" : "speaker.slash.fill")
                .foregroundColor(Color(red: 0.95, green: 0.36, blue: 0.36))
        })
        .onAppear {
            configureAudioSession()
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
        LevelOneView(isDone: .constant(true))
    }
}
