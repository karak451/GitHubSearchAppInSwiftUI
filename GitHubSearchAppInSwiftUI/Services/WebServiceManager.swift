//
//  WebServiceManager.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 27..
//

import UIKit
import Combine

enum NetworkError: Error{
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError{
    var errorDescription: String?{
        switch self{
        case .invalidURL: return NSLocalizedString("Érvénytelen URL", comment: "")
        case .responseError: return NSLocalizedString("Ismeretlen status code", comment: "")
        case .unknown: return NSLocalizedString("Ismeretlen hiba", comment: "")
        }
    }
}

class WebServiceManager: NSObject{
    static let shared = WebServiceManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Decodable>(endpoint: String, id: Int? = nil, type: T.Type) -> Future<T, Error>{
        return Future<T, Error>{ [weak self] promise in
            guard let self = self, let url = URL(string: endpoint) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap{ (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else{
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error{
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                            print("decoding hiba \(decodingError)")
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                            print("api hiba")
                        default:
                            promise(.failure(NetworkError.unknown))
                            print("ismeretlen hiba")
                        }
                    }
                    
                }, receiveValue: { data in
                    promise(.success(data))
                })
                .store(in: &self.cancellables)
            
        }
    }
}
