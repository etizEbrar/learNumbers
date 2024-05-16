import SwiftUI

struct HomeScreen: View {
    @State var missionOne: Bool = false
    let levelNames = ["Learn Numbers", "Find Asked Numbers", "Find Correct One", "Count Animals"]
    
    let levelColors: [Color] = [
        Color(red: 0.22, green: 0.44, blue: 0.87),
        Color(red: 0.95, green: 0.36, blue: 0.36),
        Color(red: 0.48, green: 0.78, blue: 0.46),
        Color(red: 0.33, green: 0.28, blue: 0.44)
    ]
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Select the Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.22, green: 0.44, blue: 0.87))
                    .padding(.top, 120)
                
                Spacer(minLength: 0)
                
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
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func viewForLevel(_ level: Int) -> some View {
        switch level {
        case 0:
            LevelOneView(isDone: $missionOne)
        case 1:
            LevelTwoView()
        case 2:
            LevelThreeView()
        case 3:
            LevelFourView()
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


