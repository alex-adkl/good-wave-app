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
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
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
    }
}

#Preview {
    ListView()
}
