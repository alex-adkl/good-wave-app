import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            Image("splash_screen") // Assurez-vous d'avoir cette image dans vos assets
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SplashScreen()
} 