//
//  AlbumsViewModel.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import Foundation
import Combine


final class RepositoriesViewModel : ObservableObject {
    
    //dependency injection
    let apiResource  : APIResourcesProtocol
    
    //subscriptions for combine
    var subscriptions = Set<AnyCancellable>()

    //the published variables
    @Published var repositories = [Repositorie]()
    
    @Published var isLoading : Bool = true

    @Published var errorMessage : String = ""{
        didSet{
            isLoading = false
            showAlert = true
        }
    }
    @Published var showAlert : Bool = false

    
    init(resources : APIResourcesProtocol = APIResources()){
        
        self.apiResource = resources
        
        apiResource.createReposPublisher()
            .receive(on : DispatchQueue.main)
            .sink{ [unowned self]
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(let errror):
                    //error handling
                    errorMessage = errror.localizedDescription
                    debugPrint(errror.localizedDescription)
                }
            } receiveValue: { [unowned self] (albums) in
                //passing data to publisher
                isLoading = false
                self.repositories = albums
            }
            .store(in : &subscriptions)
            //very important to store otherwise will not work as expected
    }
}
