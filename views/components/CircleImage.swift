import SwiftUI

struct CircleImage: View {
    var url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView() // chargement
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    CircleImage(url: URL(string: "https://images.unsplash.com/photo-1455264745730-cb3b76250ae8?q=80&w=2233&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"))
}
