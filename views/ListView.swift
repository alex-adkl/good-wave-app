//
//  ListView.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = SurfSpotViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationView {
                    VStack {
                        SearchBar()
                            .padding(.vertical, 7)
                        
                        SpotTypeSelector()
                        
                        // Text("Loaded \(viewModel.surfSpots.count) spots")
                        
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.surfSpots) { spot in
                                    NavigationLink(destination: ContentView(spot: spot)) {
                                        SpotCardView(spot: spot)
                                            .frame(maxWidth: .infinity)
                                    }
                                }.padding()
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .tag(0)
                
                Text("Saved")
                    .tag(1)
                
                Text("Profile")
                    .tag(2)
                
                Text("Share")
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    struct ListView_Previews: PreviewProvider {
        static var previews: some View {
            ListView()
        }
    }
}

#Preview {
    ListView()
}

