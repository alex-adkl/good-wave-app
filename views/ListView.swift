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
    @State private var showTabBar = true
    @State private var showSplash = true
    @State private var selectedSpotType: String?
    @State private var searchText = ""
    
    var filteredSpots: [SurfSpot] {
        var spots = viewModel.surfSpots
        
        if let selectedType = selectedSpotType {
            spots = spots.filter { spot in
                let types = spot.condition.components(separatedBy: ", ")
                return types.contains(selectedType)
            }
        }
        
        if !searchText.isEmpty {
            spots = spots.filter { spot in
                spot.title.localizedCaseInsensitiveContains(searchText) ||
                spot.location.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return spots
    }
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
                    .transition(.opacity)
            } else {
                ZStack(alignment: .bottom) {
                    TabView(selection: $selectedTab) {
                        NavigationView {
                            VStack {
                                SearchBar(searchText: $searchText) { _ in }
                                    .padding(.vertical, 7)
                                
                                SpotTypeSelector(selectedType: $selectedSpotType)
                                
                                ScrollView {
                                    VStack(spacing: 16) {
                                        ForEach(filteredSpots) { spot in
                                            NavigationLink(destination: ContentView(spot: spot)) {
                                                SpotCardView(spot: spot)
                                                    .frame(maxWidth: .infinity)
                                            }
                                        }
                                    }
                                    .padding()
                                    .padding(.bottom, 45)
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
                                .navigationBarTitleDisplayMode(.inline)
                            }
                        }
                        .tag(0)
                        
                        Text("Saved")
                            .tag(1)
                        
                        Text("Profile")
                            .tag(2)
                        
                        ShareSpotView(showTabBar: $showTabBar)
                            .tag(3)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .environmentObject(viewModel)
                    
                    CustomTabBar(selectedTab: $selectedTab)
                        .opacity(showTabBar ? 1 : 0)
                        .animation(.easeInOut(duration: 0.2), value: showTabBar)
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            viewModel.loadSurfSpots()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ListView()
}
