//
//  ContentView.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import SwiftUI

struct RepositoriesView: View {
    
    //viewmodel creation
    @StateObject var viewModel = RepositoriesViewModel()
    
    var body: some View {
        VStack{
                if viewModel.isLoading {
                    ProgressView()
                }else {
                    List(viewModel.repositories){ repo in
                        ReposRow(repo: repo)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .alert(isPresented: $viewModel.showAlert){
                Alert(title: Text("Error"),message : Text(viewModel.errorMessage))
            }
        .navigationBarTitle("Apple Repositories", displayMode: .large)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RepositoriesView()
        }
    }
}
