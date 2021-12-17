//
//  APIResourcesProtocol.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import Foundation
import Combine

/**
 Protocols for DI and for better Testing
 */

protocol APIResourcesProtocol {
    func createReposPublisher() -> AnyPublisher<[Repositorie],APIError>
}
