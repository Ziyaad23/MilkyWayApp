//
//  NetworkManager.swift
//  MilkyWay
//
//  Created by user220267 on 4/20/22.
//

import Foundation
import Combine

class NetworkManager: NetworkManagerService {

    private var subscribers = Set<AnyCancellable>()
    
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                //Failure
                case .failure(let error):
                    completion(.failure(error))
                //Success
                case .finished:
                    break
                }
            }, receiveValue: { (resultArray) in
                completion(.success(resultArray))
            }).store(in: &subscribers)
    }
}

protocol NetworkManagerService {
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

