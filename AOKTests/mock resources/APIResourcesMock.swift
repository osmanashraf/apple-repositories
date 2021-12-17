//
//  APIResourcesProtocolMock.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import Foundation
import Combine


/**
 The perfect example for  testing  the Protocol. We can create now anything to test the ApiResources
 */

struct APIResourcesMock : APIResourcesProtocol {
    
    var result : Result<[Repositorie], APIError> = .success([Repositorie(id: 1, full_name: "Swift+Combine", description: "This is Combine and My Love", created_at: "17.12.2021", watchers_count: 1244)])
    
    func createReposPublisher() -> AnyPublisher<[Repositorie], APIError> {
        return result.publisher
                .eraseToAnyPublisher()
    }
        
}
