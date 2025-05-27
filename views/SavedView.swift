//
//  SavedView.swift
//  good-wave
//
//  Created by Alejandra Adeikalam  on 14/05/2025.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var viewModel: SurfSpotViewModel
    @Binding var showTabBar: Bool

    var body: some View {
        let savedSpots = viewModel.surfSpots.filter { $0.saved }
        ZStack(alignment: .bottom) {
            NavigationView {
                ScrollView {
                    VStack(spacing: 16) {
                        HStack {
                            Text("Saved Spots")
                                .font(.largeTitle)
                                .bold()
                                .padding(.horizontal)
                            Spacer()
                        }
                        .padding(.top)
                        if savedSpots.isEmpty {
                            Text("No saved spots yet.")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top, 40)
                        } else {
                            let columns = [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ]
                            LazyVGrid(columns: columns, spacing: 32) {
                                ForEach(savedSpots) { spot in
                                    NavigationLink(destination: ContentView(spot: spot, viewModel: viewModel)) {
                                        SavedSpotGridItemView(spot: spot)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 50)
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

            CustomTabBar(selectedTab: .constant(1))
                .opacity(showTabBar ? 1 : 0)
                .animation(.easeInOut(duration: 0.2), value: showTabBar)
                
        }
    }
}

#Preview {
    SavedView(showTabBar: .constant(true))
        .environmentObject(SurfSpotViewModel())
}
