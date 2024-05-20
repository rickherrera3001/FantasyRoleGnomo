//
//  GnomoListViewModel.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 18/05/24.

import Foundation

class GnomoMasterViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredGnomes: [Brastlewark]?
    @Published var dataState: DataState = .loading
    
    private let apiClient = ApiClient()
    
    enum DataState {
        case loading
        case loaded([Brastlewark])
        case error(Error)
    }
    
    func fetchData() {
        dataState = .loading
        
        apiClient.getData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self?.filteredGnomes = list.brastlewark
                    self?.dataState = .loaded(list.brastlewark)
                case .failure(let error):
                    self?.dataState = .error(error)
                }
            }
        }
    }
}

