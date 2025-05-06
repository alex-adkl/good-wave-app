import SwiftUI

struct ShareSpotView: View {
    @Binding var showTabBar: Bool
    @State private var spotName = ""
    @State private var location = ""
    @State private var coordinates = ""
    @State private var difficulty = 3
    @State private var peakSeasonStart = Date()
    @State private var peakSeasonEnd = Date()
    @State private var websiteLink = ""
    @State private var selectedType = "Reef Break"
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    let spotTypes = ["Reef Break", "Beach Break", "Point Break", "Outer Banks"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(16)
                                .clipped()
                        } else {
                            Button(action: { showImagePicker = true }) {
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                    Text("Add Spot Photo")
                                        .foregroundColor(.gray)
                                }
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 16) {
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
                                        .foregroundColor(.black)
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
                        Text("Share Spot")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(12)
                    }
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
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
    
    private func submitSpot() {
        // TODO: Implement spot submission
        print("Submitting spot: \(spotName)")
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    ShareSpotView(showTabBar: .constant(true))
} 
