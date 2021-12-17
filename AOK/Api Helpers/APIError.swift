//
//  APIError.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import Foundation

/**
 
 The Advantage of a custom error is that we can add everytieme new Error Type which can also be testable. It is helpful by working wiht big backend and many other systems
 
 */
enum APIError : Swift.Error , CustomStringConvertible {
    
    //some knonwn cases
    case badUrl
    case url(URLError?)
    case badResponse(statuscode : Int)
    case parsing(DecodingError?)
    case unknown(Error)
    
    
    // output for user
    var localizedDescription : String {
        
        switch self {
        case .url(let error) :
            return error?.localizedDescription ?? "Something went wrong"
        case .badResponse ( _) :
            return "This was a bad Response. Please contact the Admin."
        case .parsing :
            return "Soory Parsing error"
        case .unknown :
            return "Soory unknown error"
        case .badUrl:
            return "Soory this is a bad Url"
        }
    }
    
    // output for developer
    var description: String {
        switch self {
        case .url(let error) :
            return error?.localizedDescription ?? "Something went wrong"
        case .badResponse ( let status):
            return "error \(status)"
        case .parsing (let error):
            return "Soory parsing error \(error?.localizedDescription ?? "parsing error")"
        case .badUrl : 
            return "Could not create URL"
        default :
            return "unknow error"
        }
    }
    
    // if need then convert to CustomError
    static func convert(error : Error) -> APIError {
        print(error.localizedDescription)
        switch error {
        case is URLError :
            return .url(error as? URLError)
        case is APIError :
            return error as! APIError
        default:
            return .unknown(error)
        }
    }
}
