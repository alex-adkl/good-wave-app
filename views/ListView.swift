//
// ListView.swift
// good-wave
//
// Created by Théo on 29/04/2025.
//
import SwiftUI
struct ListView: View {
  @StateObject private var viewModel = SurfSpotViewModel()
  @State private var selectedTab = 0
  @State private var showTabBar = true
  @State private var showSplash = true
  @State private var selectedSpotType: String?
  @State private var searchText = ""
  @State private var lastLoadedSpotId: String?

  @ViewBuilder
  private func spotRow(spot: SurfSpot) -> some View {
    NavigationLink(destination: ContentView(spot: spot)) {
      SpotCardView(spot: spot) {
        viewModel.toggleSaved(for: spot)
      }
      .frame(maxWidth: .infinity)
      .id(spot.id)
    }
    .frame(maxWidth: .infinity)
    .onAppear {
      let filteredSpots = self.filteredSpots
      if spot == filteredSpots.last,
         !viewModel.isLoading,
         searchText.isEmpty,
         selectedSpotType == nil {
        lastLoadedSpotId = spot.id
        Task { await viewModel.loadNextPage() }
      }
    }
  }

  var filteredSpots: [SurfSpot] {
    var spots = viewModel.surfSpots

    // Filtre par type
    if let selectedType = selectedSpotType {
      spots = spots.filter { spot in
        spot.surfBreak.contains(selectedType)
      }
    }

    // Filtre par recherche
    if !searchText.isEmpty {
      spots = spots.filter { spot in
        spot.destination.localizedCaseInsensitiveContains(searchText) ||
        spot.address.localizedCaseInsensitiveContains(searchText)
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
                if viewModel.isLoading {
                  ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                  VStack(spacing: 15) {
                    Image(systemName: "exclamationmark.triangle")
                      .font(.system(size: 40))
                      .foregroundColor(.red)
                    Text("Erreur de chargement")
                      .font(.headline)
                      .foregroundColor(.red)
                    Text(error)
                      .font(.subheadline)
                      .foregroundColor(.red)
                      .multilineTextAlignment(.center)
                      .padding(.horizontal)
                    Button(action: {
                      Task {
                        await viewModel.loadFirstPage()
                      }
                    }) {
                      Text("Réessayer")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding(.top, 10)
                  }
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .padding()
                } else {
                  ScrollView {
                    LazyVStack {
                      ForEach(filteredSpots) { spot in
                        spotRow(spot: spot)
                      }
                      if viewModel.isLoading {
                        ProgressView()
                      }
                      Spacer().frame(height: 60)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 0)
                    .background(Color.clear)
                  }
                  .frame(maxWidth: .infinity)
                  .background(Color.clear)
                  .padding(.top, 0)
                  .gesture(
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
                  .refreshable {
                    await viewModel.loadFirstPage(forceRefresh: true)
                  }
                  .padding(.bottom, 45)
                }
              }
            }
            .navigationBarTitleDisplayMode(.inline)
            .tag(0)
            good_wave.SavedView(showTabBar: $showTabBar)
              .tag(1)
            Text("Profile")
              .tag(2)
            good_wave.ShareSpotView(showTabBar: $showTabBar)
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
      Task { await viewModel.loadFirstPage() }
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
