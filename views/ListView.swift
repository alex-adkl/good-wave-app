//
//  ListView.swift
//  good-wave
//
//  Created by Théo  on 29/04/2025.
//
import SwiftUI

struct ListView: View {
    let spots: [SurfSpot] = [
        SurfSpot(imageName: "UXSpv5pRxVI8yxQyAPt28tObygpmSCRMaaxsLnfm2Oc", title: "Pipeline", location: "Oahu, Hawaii", dateRange: "22 July - 31 August", rating: 4, condition: "POOR"),
        SurfSpot(imageName: "UXSpv5pRxVI8yxQyAPt28tObygpmSCRMaaxsLnfm2Oc", title: "Pipeline", location: "Oahu, Hawaii", dateRange: "22 July - 31 August", rating: 4, condition: "POOR")
    ]

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    
                    SearchBar()
                        .padding(.vertical, 7)
                    
                    SpotTypeSelector()

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(spots) { spot in
                                SpotCardView(spot: spot)
                                    .frame(maxWidth: .infinity)
                                    
                                    
                            }
                        }.padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Explore", systemImage: "magnifyingglass")
            }

            Text("Saved").tabItem { Label("Saved", systemImage: "heart") }
            Text("Profile").tabItem { Label("Profile", systemImage: "person") }
            Text("Share").tabItem { Label("Share", systemImage: "square.and.arrow.up") }
        }
    }
}

#Preview {
    ListView()
}


