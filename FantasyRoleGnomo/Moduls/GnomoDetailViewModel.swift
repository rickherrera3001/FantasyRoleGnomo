//
//  GnomoDetailViewModel.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 17/05/24.
//


import Foundation

class GnomoDetailViewModel: ObservableObject {
    @Published var gnomo: Brastlewark
    
    init(gnomo: Brastlewark) {
        self.gnomo = gnomo
    }
}

