//
//  GnomoListViewModel.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 18/05/24.
//
import Foundation
import Combine

class GnomoListViewModel: ObservableObject {
    @Published var GnomoListView: Fantasyrole?
    @Published var error: Error?

    private let apiClient = ApiClient()

    func listData() {
        apiClient.getData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self?.GnomoListView = list
                    self?.error = nil
                    print("Results: \(list)")
                case .failure(let error):
                    self?.error = error
                    print("Error fetching data: \(error)")
                }
            }
        }
    }

    func refreshContent() {
        listData()
    }
}
