import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            tabBarItem(icon: "magnifyingglass", label: "Explore", index: 0)
            Spacer()
            tabBarItem(icon: "heart", label: "Saved", index: 1)
            Spacer()
            tabBarItem(icon: "person", label: "Profile", index: 2)
            Spacer()
            tabBarItem(icon: "plus", label: "Share", index: 3)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(
            // Glassmorphism effect
            BlurView(style: .systemUltraThinMaterial)
                .background(Color.white.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 32) // Augmenté de 16 à 32 pour descendre la barre
    }

    @ViewBuilder
    private func tabBarItem(icon: String, label: String, index: Int) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(selectedTab == index ? .black : .gray)
            Text(label)
                .font(.caption)
                .foregroundColor(selectedTab == index ? .black : .gray)
        }
        .onTapGesture {
            selectedTab = index
        }
    }
}

// Helper for glassmorphism blur
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    CustomTabBar(selectedTab: .constant(0))
} 