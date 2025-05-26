import SwiftUI

struct ProfileView: View {
    @State private var username: String = "John Doe"
    @State private var profileImage: String = "person.circle.fill"
    @Binding var showTabBar: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        Image(systemName: profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                        
                        Text(username)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 0) {
                        MenuItemView(icon: "person.fill", title: "Account Settings")
                        MenuItemView(icon: "questionmark.circle.fill", title: "Get Help")
                        MenuItemView(icon: "lock.fill", title: "Privacy")
                        MenuItemView(icon: "doc.text.fill", title: "Legal")
                        MenuItemView(icon: "person.2.fill", title: "Refer a Surfer")
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
            }
            .background(Color.white)
            .navigationTitle("Profile")
            .simultaneousGesture(
                DragGesture()
                    .onChanged { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showTabBar = false
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showTabBar = true
                        }
                    }
            )
        }
    }
}

struct MenuItemView: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            .padding()
            .background(Color.white)
        }
        Divider()
            .padding(.leading, 50)
    }
}

#Preview {
    ProfileView(showTabBar: .constant(true))
} 
