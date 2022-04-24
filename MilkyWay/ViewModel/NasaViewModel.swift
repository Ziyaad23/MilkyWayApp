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
    var nasaSubject = PassthroughSubject<RootClass, Error>()
    
    init(NetworkManager: NetworkManagerService) {
        self.NetworkManager = NetworkManager
    }
    
    //Fetch results from API
    func fetchResults() {
        let url = URL(string: "https://images-api.nasa.gov/search?q=%22%22")!
        NetworkManager.fetchItems(url: url) { [weak self] (result: Result<RootClass, Error>) in
            //Results from API
            switch result {
            //Success
            case .success(let results):
                //Store results in nasaSubjects
                self?.nasaSubject.send(results)
            //Failure
            case .failure(let error):
                self?.nasaSubject.send(completion: .failure(error))
            }
        }
    }
}
