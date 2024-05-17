//
//  ApiClient.swift
//  FantasyRoleGnomo
//
//  Created by Ricardo Developer on 17/05/24.
//

import Foundation

class ApiClient {
    
    func getData(completion: @escaping(Result<Fantasyrole, Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json")!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            do {
                let result = try JSONDecoder().decode(Fantasyrole.self, from: data)
                completion(.success(result))
            } catch{
                print("Error decoding JSON: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
