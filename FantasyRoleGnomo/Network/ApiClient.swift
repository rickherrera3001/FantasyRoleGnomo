//
//  ApiClient.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 17/05/24.
//

import Foundation

class ApiClient {
    
    func getData(completion: @escaping(Result<Fantasyrole, Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let result = try JSONDecoder().decode(Fantasyrole.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
