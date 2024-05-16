import SwiftUI

struct IntroductionView: View {
    let brightBlue = Color(red: 0.22, green: 0.44, blue: 0.87)
    let softRed = Color(red: 0.95, green: 0.36, blue: 0.36)
    let vibrantYellow = Color(red: 1.00, green: 0.84, blue: 0.25)
    let lightGreen = Color(red: 0.48, green: 0.78, blue: 0.46)
    @State private var path: [Int] = []
    var body: some View {
        NavigationStack(path: $path) {            ScrollView {
                VStack(spacing: 20) {
                    Image("welcome-illustration")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    Text("Welcome to Number Fun!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(brightBlue)
                    
                    Text("""
                        This app is designed to make learning numbers easy and fun for children starting primary education or those with special learning needs. It features 4 levels to progress through.
                        """)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(softRed)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    
                    NavigationLink(destination: HomeScreen()) {
                        Text("Start Learning")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(lightGreen)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .background(vibrantYellow) // Background color can be set here
        }
    }
}
// MARK: - Preview
struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}

