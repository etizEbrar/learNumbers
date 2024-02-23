import SwiftUI

struct HomeScreen: View {
    let levelNames = ["Level 1", "Level 2", "Level 3", "Level 4"]
    
    // Level butonlarının renkleri
    let levelColors: [Color] = [
        Color(red: 0.22, green: 0.44, blue: 0.87), // brightBlue
        Color(red: 0.95, green: 0.36, blue: 0.36), // softRed
        Color(red: 1.00, green: 0.84, blue: 0.25), // vibrantYellow
        Color(red: 0.48, green: 0.78, blue: 0.46)  // lightGreen
    ]

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Select the Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.22, green: 0.44, blue: 0.87)) // brightBlue
                    .padding(.top, 100) // Yazıyı ve butonları yukarıdan biraz daha aşağı al

                Spacer(minLength: 10) // Text ile butonlar arasında 30 piksel boşluk

                ForEach(Array(zip(levelNames.indices, levelNames)), id: \.0) { index, levelName in
                    NavigationLink(destination: viewForLevel(index)) {
                        Text(levelName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(levelColors[index])
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                }
                Spacer() // Butonları ve yazıyı ekranın altına itmek için
            }
        }
    }
    
    @ViewBuilder
                    private func viewForLevel(_ level: Int) -> some View {
                        switch level {
                        case 0:
                            LevelOneView()
                        case 1:
                            LevelTwoView() // LevelTwoView yapısını oluşturmanız gerekmektedir
                        case 2:
                           LevelThreeView() // LevelThreeView yapısını oluşturmanız gerekmektedir
                        case 3:
                            LevelFourView() // LevelFourView yapısını oluşturmanız gerekmektedir
                        default:
                            EmptyView()
                        }
                    }
                }

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

// LevelOneView, LevelTwoView, LevelThreeView ve LevelFourView yapısınızı buraya kopyalayın veya ayrı bir dosyada tutun.
