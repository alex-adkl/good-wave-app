import SwiftUI

struct ProfileView: View {
    @State private var username: String = "John Doe"
    @State private var profileImage: String = "jd_Profile"
    @Binding var showTabBar: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text("Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        VStack(spacing: 12) {
                            Image(profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.blue.opacity(0.5), lineWidth: 20)
                                )
                                .padding(.bottom, 15)
                            Text(username)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.bottom, 10)
                            Button(action: {}) {
                                Text("Edit Profile")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 32)
                                    .padding(.vertical, 15)
                                    .background(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color(.systemGray3), lineWidth: 1)
                                    )
                                    .padding(.bottom, 15)
                            }
                        }
                        HStack(spacing: 0) {
                            ProfileIconButton(icon: "questionmark.circle", label: "Get Help")
                                .fontWeight(.semibold)
                            Divider().frame(height: 40)
                            ProfileIconButton(icon: "hand.raised", label: "Privacy")
                                .fontWeight(.semibold)
                            Divider().frame(height: 40)
                            ProfileIconButton(icon: "exclamationmark.triangle", label: "Legal")
                                .fontWeight(.semibold)
                            Divider().frame(height: 40)
                            ProfileIconButton(icon: "gearshape", label: "Settings")
                                .fontWeight(.semibold)
                        }
                        .padding(.bottom, 15)
                    
                        .padding(.horizontal)
                        ProfileSectionRow(title: "Inbox", subtitle: "View messages", icon: "chevron.right")
                        ProfileSectionRow(title: "Your Member Benefits", subtitle: "No benefits yet", icon: "chevron.right")
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Friends")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.bottom, 10)
                            Button(action: {}) {
                                Text("REFER YOUR FRIENDS")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 17)
                                    .background(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color(.systemGray3), lineWidth: 1)
                                    )
                                    .padding(.bottom, 70)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
        }
    }
}

struct ProfileIconButton: View {
    let icon: String
    let label: String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.black)
            Text(label)
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileSectionRow: View {
    let title: String
    let subtitle: String
    let icon: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 12)
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView(showTabBar: .constant(true))
} 
