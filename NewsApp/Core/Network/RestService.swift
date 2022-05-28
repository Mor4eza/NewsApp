    //
    //  Network.swift
    //  NewsApp
    //
    //  Created by Morteza on 4/14/22.
    //

import Foundation

class RestService<R: Request>: Service {
    
    typealias ResultType = R.ResultType
    typealias ErrorType = RestError
    
    private let cacher: URLCache
    private let session: URLSession
    private let request: R
    var currentTask: Task?
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared,
         configuration: URLSessionConfiguration = .default,
         cacher: URLCache = .shared,
         decoder: JSONDecoder = JSONDecoder(),
         request: R) {
        
        self.session = URLSession(configuration: configuration)
        self.cacher = cacher
        self.request = request
        self.decoder = decoder
    }
    
    func defaultHeaders(_ orphanRequest: URLRequest) -> URLRequest {
        var request = orphanRequest
        request.allHTTPHeaderFields?.updateValue("application/json", forKey: "Content-Type")
        return request
    }
    
    //MARK: - Create Task Funcation
    private func createTask(callback: @escaping (Result<R.ResultType, RestError>, Bool) -> Void) -> Task {
        guard var urlRequest = try? request.asURLRequest() else {
            fatalError("Request is not correctly formatted.")
        }
        let cache = request.acceptCache
        if !cache {
            cacher.removeCachedResponse(for: urlRequest)
        }
        urlRequest = defaultHeaders(urlRequest)
//        urlRequest = tokenize(urlRequest)
        if let body = urlRequest.httpBody {
            print("API, Request Created -->  \(urlRequest.httpMethod!) \n \(urlRequest.url?.absoluteString ?? "") : BODY:\n \(String(data: body, encoding: .utf8)!)")
        } else {
            print("API, Request Created -->  \(urlRequest.httpMethod!) \n \(urlRequest.url?.absoluteString ?? "")")
        }
        return self.session.dataTask(with: urlRequest) {(data, response, error) in
            
            guard let data = data else {
//                log.error("API, Data is not found for -->\(urlRequest.httpMethod ?? "")   \(urlRequest.url?.absoluteString ?? "")")
                if let error = error {
                    callback(.failure(.transportError(error)), true)
                } else {
                    callback(.failure(.noData), true)
                }
                return
            }
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200, let serverError: Models.ServerError = try? self.decoder.decode(Models.ServerError.self, from: data) {
//                callback(.failure(.serverError(statusCode: httpResponse.statusCode)), true)
////                self.prettyPrint(data)
//                return
//            }
            print("API, Data received --> \(urlRequest.httpMethod ?? "")  \(urlRequest.url?.absoluteString ?? "") \n \(String(data: data, encoding: .utf8)!)")
            
            do {
                let model: R.ResultType = try self.decoder.decode(R.ResultType.self, from: data)
                if cache {
                    self.cacher.cachedResponse(for: urlRequest)
                }
                print("API, \(urlRequest.httpMethod ?? "")  \(urlRequest.url?.absoluteString ?? "")")
                dump(model)
                callback(.success(model), true)
//                self.prettyPrint(data)
                
            } catch (let decodeError){
                if let data = data as? R.ResultType{
                    callback(.success(data), true)
                    print("API, \(urlRequest.httpMethod ?? "")  \(urlRequest.url?.absoluteString ?? "")")
                    return
                } else {
                    callback(.failure(.decodingError(error!)), true)
                }
                print("API, Data is not parsable for --> \(urlRequest.httpMethod ?? "")  \(urlRequest.url?.absoluteString ?? "")" )
                dump(decodeError)
//                self.prettyPrint(data)
                
                return
            }
        }
    }
    
    func call(callback: @escaping (Result<R.ResultType, RestError>, Bool) -> Void) -> Task {
        self.currentTask = createTask(callback: callback)
        return currentTask!
    }
    
//    func call<T>(req: T, _ completion: @escaping (Result<T.ResultType, RestError>) -> Void) where T :Request {
//        let request = prepareRequest(req: req)
//        session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(.failure(.transportError(error)))
//                }
//                return
//            }
//
//            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//                completion(.failure(.serverError(statusCode: response.statusCode)))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            let decoder = JSONDecoder()
//            do {
//                let decodedResponse = try decoder.decode(T.ResultType.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(decodedResponse))
//                }
//            } catch {
//                completion(.failure(.decodingError(error)))
//            }
//
//        }.resume()
//
//    }
}

//extension RestService {
//    private func prepareRequest<T: Request>(req: T) -> URLRequest {
//        guard let url = URL(string: Constants.baseURL + req.path) else {
//            fatalError("URL incorrect")
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = req.method.rawValue
//        return request
//    }
//}

enum RestError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}
