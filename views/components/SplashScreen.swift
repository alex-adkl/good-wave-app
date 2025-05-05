//
//  SplashScreen.swift
//  good-wave
//
//  Created by Théo  on 05/05/2025.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            Image("splash_screen")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SplashScreen()
}
