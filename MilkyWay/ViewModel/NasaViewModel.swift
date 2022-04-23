//
//  NasaViewModel.swift
//  MilkyWay
//
//  Created by user220267 on 4/23/22.
//

import Foundation
import Combine

class NasaViewModel {

    // Dependency Injection
    private let NetworkManager: NetworkManagerService
    
    var nasaInfos: [NasaInfo] = []
    var nasaSubject = PassthroughSubject<RootClass, Error>()
    
    init(NetworkManager: NetworkManagerService) {
        self.NetworkManager = NetworkManager
    }
    
    func fetchResults() {
        let url = URL(string: "https://images-api.nasa.gov/search?q=''")!
        NetworkManager.fetchItems(url: url) { [weak self] (result: Result<RootClass, Error>) in
            //(result)
            switch result {
            case .success(let results):
                self?.nasaSubject.send(results)
            case .failure(let error):
                self?.nasaSubject.send(completion: .failure(error))
            }
        }
    }
    
}
