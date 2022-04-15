//
//  Network.swift
//  NewsApp
//
//  Created by Morteza on 4/14/22.
//

import Foundation

protocol NetworkClient {
    var session: URLSession {get}
    func request<T: Requstable>(req: T, _ completion: @escaping (Result<T.responseType, Error>) -> Void)
}

class Network: NetworkClient {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func request<T>(req: T, _ completion: @escaping (Result<T.responseType, Error>) -> Void) where T : Requstable {
        let request = prepareRequest(req: req)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let decodedResponse = try decoder.decode(T.responseType.self, from: data)
                            DispatchQueue.main.async {
                                completion(.success(decodedResponse))
                            }
                        } catch {
                            print(error)
                        }
                    } else {
                        
                    }
                }
            }
        }.resume()
        
    }
}

extension Network {
    private func prepareRequest<T: Requstable>(req: T) -> URLRequest {
        guard let url = URL(string: Constants.baseURL + req.path) else {
            fatalError("URL incorrect")
        }
        var request = URLRequest(url: url)
        request.httpMethod = req.method.rawValue
        return request
    }
}
