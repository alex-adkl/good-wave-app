//
//  ListView.swift
//  good-wave
//
//  Created by Théo on 29/04/2025.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = SurfSpotViewModel()


    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    SearchBar()
                        .padding(.vertical, 7)
                    
                    SpotTypeSelector()
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.surfSpots) { spot in
                                NavigationLink(destination: ContentView(spot: spot)) {
                                    SpotCardView(spot: spot)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .padding()
                            
                            @State private var selectedTab = 0
                            @State private var showTabBar = true
                            @State private var showSplash = true
                            
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
                                                        SearchBar()
                                                            .padding(.vertical, 7)
                                                        
                                                        SpotTypeSelector()
                                                        
                                                        ScrollView {
                                                            LazyVStack(spacing: 16) {
                                                                ForEach(viewModel.surfSpots) { spot in
                                                                    NavigationLink(destination: ContentView(spot: spot)) {
                                                                        SpotCardView(spot: spot)
                                                                            .frame(maxWidth: .infinity)
                                                                    }
                                                                }.padding()
                                                            }
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
                                            
                                            CustomTabBar(selectedTab: $selectedTab)
                                                .opacity(showTabBar ? 1 : 0)
                                                .animation(.easeInOut(duration: 0.2), value: showTabBar)
                                        }
                                        
                                        .onAppear {
                                            viewModel.loadSurfSpots()
                                        }
                                    }
                                        .tabItem {
                                            Label("Explore", systemImage: "magnifyingglass")
                                        }
                                    
                                    Text("Saved")
                                        .tabItem {
                                            Label("Saved", systemImage: "heart")
                                        }
                                    
                                    Text("Profile")
                                        .tabItem {
                                            Label("Profile", systemImage: "person")
                                        }
                                    
                                    Text("Share")
                                        .tabItem {
                                            Label("Share", systemImage: "square.and.arrow.up")
                                        }
                                }
                                .transition(.opacity)
                            }
                        }
                        .onAppear {
                            viewModel.loadSurfSpots {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showSplash = false
                                    }
                                }
                            }
                        }
                        
                    }
                }}
            
            #Preview {
                ListView()
            }
        }
