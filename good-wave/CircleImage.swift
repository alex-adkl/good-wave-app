//
//  CircleImage.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM on 28/04/2025.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("UXSpv5pRxVI8yxQyAPt28tObygpmSCRMaaxsLnfm2Oc")
            .resizable()
            .scaledToFill()
                .frame(width: 200, height: 200)
            .clipShape(Circle())
            
    }
}

#Preview {
    CircleImage()
}
