//
//  AOKTests.swift
//  AOKTests
//
//  Created by Osman Ashraf on 17.12.21.
//

import XCTest
import Combine
@testable import AOK

/**
Executed 5 tests, with 0 failures (0 unexpected) in 0.017 (0.030) seconds. The Time is very imporant while Testing a huge Project.
 */

class AOKTests: XCTestCase {

    var subscriptiopns = Set<AnyCancellable>()
    
    override func tearDown() {
        //to be clear that all subscriptiopns are cancel
        subscriptiopns = []
    }
    
    func testInitialReposFetch(){
        let fetcher = RepositoriesViewModel(resources: APIResourcesMock())
        
        //cause of async
        let promise = expectation(description: "loading albums in init")
        fetcher.$repositories.sink { (repos) in
            //test the mock 1 Data
            if repos.count == 1 {
                promise.fulfill()
            }
        }
        .store(in: &subscriptiopns)
        
        wait(for: [promise], timeout: 1)
    }
    
    func testErrorBadReponse(){
        let error = APIError.badResponse(statuscode: 404)
        let mock = APIResourcesMock(result: .failure(error))
        let fetcher = RepositoriesViewModel(resources: mock)
        let promise = expectation(description: "This was a bad Response. Please contact the Adminssss")
        
        //check if repos get any data?
        fetcher.$repositories
            .filter({$0.count > 0})
            .sink{ repos in
            XCTFail("should not havea any data")
        }.store(in: &subscriptiopns)
        
        
        //check if errormeasse get his property
        fetcher.$errorMessage
            .filter({ !$0.isEmpty})
            .sink { (message) in
                if error.localizedDescription == message {
                    promise.fulfill()
                }

        }.store(in: &subscriptiopns)
        wait(for: [promise], timeout: 1)
    }
    
    func testErrorBadUrl(){
        let error = APIError.badUrl
        let mock = APIResourcesMock(result: .failure(error))
        let fetcher = RepositoriesViewModel(resources: mock)
        let promise = expectation(description: "Soory this is a bad Url")
        
        //check if repos get any data?
        fetcher.$repositories
            .filter({$0.count > 0})
            .sink{ repos in
            XCTFail("should not havea any data")
        }.store(in: &subscriptiopns)
        
        
        //check if errormeasse get his property
        fetcher.$errorMessage
            .filter({ !$0.isEmpty})
            .sink { (message) in
                if error.localizedDescription == message {
                    promise.fulfill()
                }

        }.store(in: &subscriptiopns)
        wait(for: [promise], timeout: 1)
    }
    
    func testParsingError(){
        let error = APIError.parsing(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: description)))
        let mock = APIResourcesMock(result: .failure(error))
        let fetcher = RepositoriesViewModel(resources: mock)
        let promise = expectation(description: "Soory parsing errorl")
        
        //check if repos get any data?
        fetcher.$repositories
            .filter({$0.count > 0})
            .sink{ repos in
            XCTFail("should not havea any data")
        }.store(in: &subscriptiopns)
        
        
        //check if errormeasse get his property
        fetcher.$errorMessage
            .filter({ !$0.isEmpty})
            .sink { (message) in
                if error.localizedDescription == message {
                    promise.fulfill()
                }

        }.store(in: &subscriptiopns)
        wait(for: [promise], timeout: 1)
    }
    
    //The Internet connection appears to be offline
    
    func testNoConnectionToInnternetError(){
        let error = APIError.url(URLError(URLError.notConnectedToInternet))
        let mock = APIResourcesMock(result: .failure(error))
        let fetcher = RepositoriesViewModel(resources: mock)
        let promise = expectation(description: "The Internet connection appears to be offline")
        
        //check if repos get any data?
        fetcher.$repositories
            .filter({$0.count > 0})
            .sink{ repos in
            XCTFail("should not havea any data")
        }.store(in: &subscriptiopns)
        
        
        //check if errormeasse get his right property
        fetcher.$errorMessage
            .filter({ !$0.isEmpty})
            .sink { (message) in
                if error.localizedDescription == message {
                    promise.fulfill()
                }

        }.store(in: &subscriptiopns)
        wait(for: [promise], timeout: 1)
    }
}
