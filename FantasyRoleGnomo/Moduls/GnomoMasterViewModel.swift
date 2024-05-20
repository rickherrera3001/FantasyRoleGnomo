//
//  GnomoListViewModel.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 18/05/24.

import Foundation
import Combine

class GnomoMasterViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredGnomes: [Brastlewark]?
    @Published var dataState: DataState = .loading
    
    private var allGnomes: [Brastlewark] = []
    private var cancellables = Set<AnyCancellable>()
    private let apiClient = ApiClient()
    
    enum DataState {
        case loading
        case loaded([Brastlewark])
        case error(Error)
    }
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.filterGnomes(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        dataState = .loading
        
        apiClient.getData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self?.allGnomes = list.brastlewark
                    self?.filterGnomes(with: self?.searchText ?? "")
                case .failure(let error):
                    self?.dataState = .error(error)
                }
            }
        }
    }
    
    private func filterGnomes(with query: String) {
        if query.isEmpty {
            filteredGnomes = allGnomes
        } else {
            filteredGnomes = allGnomes.filter { gnomo in
                gnomo.name.lowercased().contains(query.lowercased()) ||
                gnomo.professions.map { $0.rawValue.lowercased() }.contains { $0.contains(query.lowercased()) }
            }
        }
        dataState = .loaded(filteredGnomes ?? [])
    }
}

