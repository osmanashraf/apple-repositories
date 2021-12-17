//
//  Albums.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import Foundation

struct Repositorie : Codable , Identifiable{
    let id : Int
    let full_name : String?
    let description : String?
    var created_at : String?
    let watchers_count : Int?
    
    public var watchers_countWrapped : Int{
        watchers_count ?? 0
    }
    
    var stringToDate: Date? {
        guard let dateWrapped = created_at else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return dateFormatter.date(from: dateWrapped)
    }
    
    public var formatDate : String {

        guard let wrappedDate = stringToDate else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: wrappedDate)
    }
}
