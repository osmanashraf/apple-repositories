//
//  ReposRow.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import SwiftUI

struct ReposRow: View {
    
    var repo : Repositorie
    
    var body: some View {
        VStack(alignment:.leading){
            
            Text(repo.full_name ?? "")
                .padding(.vertical)
                .font(.title2)
                .foregroundColor(.blue)
            
            if let desc = repo.description {
                Text(desc).font(.subheadline)
            }
            
            DateWithWatchersRow(repo: repo)
        }
        .padding()
    }
}

struct ReposRow_Previews: PreviewProvider {
    static var previews: some View {
        ReposRow(repo: Repositorie(id: 1, full_name: "Swift+Combine!", description: "The Swift Programming Langugage", created_at: "2015-10-12T22:33:18Z", watchers_count: 17127))
    }
}

struct DateWithWatchersRow :  View {
    
    var repo : Repositorie
    
    var body: some View {
        HStack{
            Text(repo.formatDate)
            Spacer()
            HStack{
                Text("\(repo.watchers_countWrapped)")
                Image(systemName: "eye.fill")
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical)
        .font(.system(size: 14))
        .foregroundColor(.gray)
    }
}
struct DateWithWatchersRow_Previews: PreviewProvider {
    static var previews: some View {
        DateWithWatchersRow(repo: Repositorie(id: 1, full_name: "Swift+Combine!", description: "The Swift Programming Langugage", created_at: "2015-10-12T22:33:18Z", watchers_count: 17127))
    }
}

