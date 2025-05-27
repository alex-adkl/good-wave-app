//
//  ListView.swift
//  good-wave
//
//  Created by Alejandra ADEIKALAM  on 28/04/2025.
//

import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var temperature: Double?
    @Published var windKph: Double?
    @Published var isLoading = false
    @Published var error: String?

    func fetchWeather(lat: Double, lon: Double) {
        isLoading = true
        let apiKey = "57016d3ef46f4950b3f113737252705"
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(lat),\(lon)&lang=fr"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                        self.temperature = decoded.current.temp_c
                        self.windKph = decoded.current.wind_kph
                    } catch {
                        self.error = "Erreur de décodage météo"
                    }
                } else {
                    self.error = "Erreur réseau météo"
                }
            }
        }.resume()
    }

    func fetchWeatherByQuery(query: String) {
        isLoading = true
        let apiKey = "57016d3ef46f4950b3f113737252705"
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(query)&lang=fr"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
                        self.temperature = decoded.current.temp_c
                        self.windKph = decoded.current.wind_kph
                    } catch {
                        self.error = "Erreur de décodage météo (adresse)"
                    }
                } else {
                    self.error = "Erreur réseau météo (adresse)"
                }
            }
        }.resume()
    }
}

struct WeatherAPIResponse: Decodable {
    struct Current: Decodable {
        let temp_c: Double
        let wind_kph: Double
    }
    let current: Current
}

func colorForDifficulty(_ level: Int) -> Color {
    switch level {
    case 1...2:
        return .green
    case 3:
        return .orange
    case 4...5:
        return .red
    default:
        return .gray
    }
}

struct ContentView: View {
    let spot: SurfSpot
    @ObservedObject var viewModel: SurfSpotViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showFullMap = false
    @StateObject private var weatherVM = WeatherViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    if let url = URL(string: spot.photoURL) {
                        AsyncImageView(url: url, placeholder: "photo")
                            .frame(height: 250)
                    }
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        Spacer()
                        Button(action: {
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        Button(action: {
                            viewModel.toggleSaved(for: spot)
                        }) {
                            let isSaved = viewModel.surfSpots.first(where: { $0.id == spot.id })?.saved ?? false
                            Image(systemName: isSaved ? "heart.fill" : "heart")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.pink)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 15)
                    VStack {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .padding(.horizontal, 0)
                            .padding(.top, 240)
                        Spacer()
                    }
                }
                .ignoresSafeArea(.all, edges: .top)
                ZStack(alignment: .bottom) {
                    Color.clear.frame(height: 0)
                    MapView()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.clear, lineWidth: 1)
                        )
                        .offset(y: 30)
                        .shadow(radius: 7)
                        .onTapGesture {
                            showFullMap = true
                        }
                }
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text(spot.destination)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                        Text(spot.country)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(spot.surfBreak.joined(separator: " • "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                        if let temp = weatherVM.temperature, let wind = weatherVM.windKph {
                            HStack(spacing: 16) {
                                HStack(spacing: 4) {
                                    Image(systemName: "thermometer")
                                    Text("\(Int(temp))°C")
                                }
                                HStack(spacing: 4) {
                                    Image(systemName: "wind")
                                    Text("\(Int(wind)) km/h")
                                }
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        } else if weatherVM.isLoading {
                            ProgressView().scaleEffect(0.7)
                        } else if let error = weatherVM.error {
                            Text(error).font(.caption).foregroundColor(.red)
                        }
                    }
                    .padding(.top, 50)
                    VStack(spacing: 20) {
                        InfoCard(
                            title: "Difficulty Level",
                            icon: "crown.fill",
                            content: {
                                HStack(spacing: 4) {
                                    ForEach(0..<spot.difficultyLevel, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(colorForDifficulty(spot.difficultyLevel))
                                    }
                                }
                            }
                        )
                        InfoCard(
                            title: "Peak Season",
                            icon: "figure.surfing",
                            content: {
                                Text("\(spot.formattedPeakSeasonBegins) - \(spot.formattedPeakSeasonEnds)")
                                    .foregroundColor(.primary)
                            }
                        )
                        if let temp = weatherVM.temperature, let wind = weatherVM.windKph {
                            HStack(spacing: 16) {
                                HStack(spacing: 4) {
                                    Image(systemName: "thermometer")
                                    Text("\(Int(temp))°C")
                                }
                                HStack(spacing: 4) {
                                    Image(systemName: "wind")
                                    Text("\(Int(wind)) km/h")
                                }
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        } else if weatherVM.isLoading {
                            ProgressView().scaleEffect(0.7)
                        } else if let error = weatherVM.error {
                            Text(error).font(.caption).foregroundColor(.red)
                        }
                        if let url = URL(string: spot.forecastURL ?? "") {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "arrow.up.right.circle.fill")
                                    Text("View Forecast")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 90)
            }
        }
        .background(Color.clear)
        .ignoresSafeArea(.all, edges: .top)
        .navigationBarHidden(true)
        .onAppear {
            if let (lat, lon) = extractLatLon(from: spot.geocode) {
                weatherVM.fetchWeather(lat: lat, lon: lon)
            } else if let address = spot.address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !address.isEmpty {
                weatherVM.fetchWeatherByQuery(query: address)
            } else if let destination = spot.destination.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !destination.isEmpty {
                weatherVM.fetchWeatherByQuery(query: destination)
            }
        }
        .sheet(isPresented: $showFullMap) {
            ZStack(alignment: .topTrailing) {
                MapView()
                    .edgesIgnoringSafeArea(.all)
                Button(action: {
                    showFullMap = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .shadow(radius: 4)
                        .padding()
                }
            }
        }
    }
}

struct InfoCard<Content: View>: View {
    let title: String
    let icon: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(.primary)
            
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

func extractLatLon(from geocode: String?) -> (Double, Double)? {
    guard let geocode = geocode else { return nil }
    let regex = try? NSRegularExpression(pattern: "(-?\\d+\\.\\d+),\\s*(-?\\d+\\.\\d+)")
    if let match = regex?.firstMatch(in: geocode, range: NSRange(geocode.startIndex..., in: geocode)),
       let latRange = Range(match.range(at: 1), in: geocode),
       let lonRange = Range(match.range(at: 2), in: geocode) {
        let lat = Double(geocode[latRange])
        let lon = Double(geocode[lonRange])
        if let lat = lat, let lon = lon {
            return (lat, lon)
        }
    }
    return nil
}

