//
//  APIGetToken.swift
//
//  Created by Александра on 28.04.2021.
//

import Combine
import Foundation

public class APIGetToken {
    public static let shared = APIGetToken()
        
    var cancellables = Set<AnyCancellable>()
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString: String,
                                      idClient: String,
                                      paramValue: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let client1 = Client(
            idClient: idClient,
            accessToken: "",
            paramName: "device",
            paramValue: paramValue,
            latitude: 0,
            longitude: 0,
            sourceQuery: 0)
        guard let encoded = try? JSONEncoder().encode(client1) else {
            print("Failed to encode client")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("891cf53c-01fc-4d74-a14c-592668b7a03c", forHTTPHeaderField: "AccessKey")
        request.setValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { (taskCompletion) in
                switch taskCompletion {
                case .finished:
                    return
                case .failure(let decodingError):
                    completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                }
                
            } receiveValue: { (decodedData) in
                completion(.success(decodedData))
            }
            .store(in: &cancellables)
    }
}
