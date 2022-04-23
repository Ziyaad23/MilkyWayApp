//
//  NasaViewModel.swift
//  MilkyWay
//
//  Created by user220267 on 4/23/22.
//

import Foundation
import Combine

class UsersViewModel {

    // Dependency Injection
    private let apiManager: APIManagerService
    
    var nasaInfos: [NasaInfo] = []
    var nasaSubject = PassthroughSubject<RootClass, Error>()
    
    init(apiManager: APIManagerService) {
        self.apiManager = apiManager
    }
    
    func fetchResults() {
        let url = URL(string: "https://images-api.nasa.gov/search?q=''")!
        apiManager.fetchItems(url: url) { [weak self] (result: Result<RootClass, Error>) in
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
