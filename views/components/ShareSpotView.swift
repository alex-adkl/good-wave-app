import SwiftUI
import UIKit

struct ShareSpotView: View {
    @Binding var showTabBar: Bool
    @StateObject private var viewModel = SurfSpotViewModel()
    @State private var spotName = ""
    @State private var location = ""
    @State private var coordinates = ""
    @State private var difficulty = 3
    @State private var peakSeasonStart = Date()
    @State private var peakSeasonEnd = Date()
    @State private var websiteLink = ""
    @State private var selectedType = "Reef Break"
    @State private var imageURL = ""
    @State private var isSubmitting = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let spotTypes = ["Reef Break", "Beach Break", "Point Break", "Outer Banks"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack {
                        if let url = URL(string: imageURL), !imageURL.isEmpty {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(16)
                                        .clipped()
                                case .failure:
                                    ZStack {
                                        Color(.systemGray6)
                                        Image(systemName: "photo")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                        Text("Invalid URL")
                                            .foregroundColor(.gray)
                                            .offset(y: 40)
                                    }
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(16)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            ZStack {
                                Color(.systemGray6)
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                                Text("Paste image URL below")
                                    .foregroundColor(.gray)
                                    .offset(y: 40)
                            }
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text("Image URL")
                                .font(.headline)
                            TextField("https://...", text: $imageURL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Spot Name")
                                .font(.headline)
                            TextField("Enter spot name", text: $spotName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Location")
                                .font(.headline)
                            TextField("City, country", text: $location)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Coordinates")
                                .font(.headline)
                            TextField("Latitude, Longitude", text: $coordinates)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Difficulty Level")
                                .font(.headline)
                            HStack {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= difficulty ? "star.fill" : "star")
                                        .foregroundColor(.red.opacity(0.7))
                                        .onTapGesture {
                                            difficulty = star
                                        }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Peak Season")
                                .font(.headline)
                            HStack {
                                DatePicker("Start", selection: $peakSeasonStart, displayedComponents: .date)
                                DatePicker("End", selection: $peakSeasonEnd, displayedComponents: .date)
                            }
                            .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Surf Forecast")
                                .font(.headline)
                            TextField("https://", text: $websiteLink)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Spot Type")
                                .font(.headline)
                            Picker("Select type", selection: $selectedType) {
                                ForEach(spotTypes, id: \.self) { type in
                                    Text(type).tag(type)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical, 8)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: submitSpot) {
                        if isSubmitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Share Spot")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
                    .disabled(isSubmitting || !isFormValid)
                    .opacity(isFormValid ? 1.0 : 0.5)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 60)
                }
                .padding(.vertical)
            }
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
            .navigationTitle("Share Spot")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Message"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private var isFormValid: Bool {
        !spotName.isEmpty &&
        !location.isEmpty &&
        !coordinates.isEmpty &&
        !websiteLink.isEmpty &&
        !imageURL.isEmpty
    }
    
    private func submitSpot() {
        isSubmitting = true
        
        viewModel.submitSpot(
            name: spotName,
            location: location,
            coordinates: coordinates,
            difficulty: difficulty,
            peakSeasonStart: peakSeasonStart,
            peakSeasonEnd: peakSeasonEnd,
            websiteLink: websiteLink,
            type: selectedType,
            imageURL: imageURL
        ) { success in
            isSubmitting = false
            if success {
                alertMessage = "Your spot has been shared"
                spotName = ""
                location = ""
                coordinates = ""
                difficulty = 3
                peakSeasonStart = Date()
                peakSeasonEnd = Date()
                websiteLink = ""
                selectedType = "Reef Break"
                imageURL = ""
            } else {
                alertMessage = "Error sharing spot. Please try again."
            }
            showAlert = true
        }
    }
}

#Preview {
    ShareSpotView(showTabBar: .constant(true))
}
