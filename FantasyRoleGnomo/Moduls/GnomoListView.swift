//
//  GnomoListView.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 18/05/24.
//


import SwiftUI
import Kingfisher

struct GnomoListView: View {
    @StateObject private var viewModel = GnomoListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let gnomos = viewModel.GnomoListView?.brastlewark { // Cambiamos a viewModel.GnomoListView
                    List(gnomos) { gnomo in
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
                    .listRowBackground(Color(red: 19/255, green: 30/255, blue: 53/255)) // Color de fondo azul para las filas de la lista
                } else if let error = viewModel.error {
                    Text("Failed to load data: \(error.localizedDescription)")
                } else {
                    Text("Loading...")
                }
            }
            .navigationTitle("Gnomos")
            .onAppear {
                viewModel.listData()
            }
        }
        .foregroundColor(.gray) // Color de texto predeterminado en blanco para una mejor visibilidad
    }
}

struct GnomoListView_Previews: PreviewProvider {
    static var previews: some View {
        GnomoListView()
    }
}
