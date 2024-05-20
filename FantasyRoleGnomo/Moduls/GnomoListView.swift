//
//  GnomoListView.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 18/05/24.

import SwiftUI
import Kingfisher

struct GnomoListView: View {
    @ObservedObject var viewModel = GnomoMasterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                
                switch viewModel.dataState {
                case .loading:
                    ProgressView()
                case .loaded(let gnomes):
                    List(gnomes) { gnomo in
                        NavigationLink(destination: GnomoDetailView(gnome: gnomo)) {
                            GnomoListRowView(gnomo: gnomo)
                        }
                    }
                case .error(let error):
                    Text("Failed to load data: \(error.localizedDescription)")
                }
            }
            .navigationTitle("Gnomos")
            .onAppear {
                viewModel.fetchData()
            }
        }
        .foregroundColor(.gray)
    }
}
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
        .padding(.horizontal)
    }
}

struct GnomoListRowView: View {
    let gnomo: Brastlewark

    var body: some View {
        VStack(alignment: .center) {
            KFImage(URL(string: gnomo.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .cornerRadius(50)
                .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 6)
            
            Spacer().frame(height: 35)
            Text("Name: ").italic()
                .foregroundColor(.gray) +
                Text("\(gnomo.name)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer().frame(height: 15)
            Text("Age: ").italic()
                .foregroundColor(.gray) +
                Text("\(gnomo.age)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer().frame(height: 15)
            Text("Hair Color: ").italic()
                .foregroundColor(.gray) +
                Text("\(gnomo.hairColor.rawValue)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer().frame(height: 15)
            Text("Professions: ").italic()
                .foregroundColor(.gray) +
                Text(gnomo.professions.map { $0.rawValue }.joined(separator: ", "))
                .font(.subheadline)
                .foregroundColor(.blue)
            Spacer().frame(height: 15)
        }
        .padding()
    }
}

#Preview {
    GnomoListView()
}

