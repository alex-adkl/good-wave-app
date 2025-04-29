import SwiftUI

struct BackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(.blue)
                .padding()
                .background(Color.white.opacity(0.8))
                .clipShape(Circle())
        }
    }
}
