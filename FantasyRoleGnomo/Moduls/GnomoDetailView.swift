//
//  GnomoDetailView.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 19/05/24.
//

import SwiftUI
import Kingfisher

struct GnomoDetailView: View {
    let gnome: Brastlewark
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(URL(string: gnome.thumbnail))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .padding(.top, 20)
                
                Text("Name: \(gnome.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("Age: \(gnome.age)")
                    .font(.title2)
                    .padding(.top, 10)
                
                Text("Weight: \(gnome.weight)")
                    .font(.title2)
                    .padding(.top, 10)
                
                Text("Height: \(gnome.height)")
                    .font(.title2)
                    .padding(.top, 10)
                
                Text("Hair Color: \(gnome.hairColor.rawValue)")
                    .font(.title2)
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Professions:")
                        .font(.title2)
                        .padding(.top, 20)
                    
                    ForEach(gnome.professions, id: \.self) { profession in
                        Text(profession.rawValue)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .navigationTitle("Gnomo Detail")
    }
}

struct GnomoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let testGnomo = Brastlewark(id: 0, name: "Test Gnomo", thumbnail: "https://example.com/image.jpg", age: 100, weight: 50.5, height: 120.0, hairColor: .black, professions: [.baker, .blacksmith], friends: [])
        
        NavigationView {
            GnomoDetailView(gnome: testGnomo)
        }
    }
}

