//
//  ReszletezesView.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 26..
//

import SwiftUI

struct ReszletezesView: View{
    let repoURL: String
    
    @ObservedObject var rvm = ReszletezesViewModel()
    @Environment(\.openURL) private var openURL
    
    var body: some View{
        VStack(alignment: .leading){
            if(rvm.betoltesStatusz == .vegzett){
             
                DatumCsillagFork(rvm: rvm)
                
                Description(rvm: rvm)
                Spacer().frame(height: 50)
                
                Text("Owner:")
                    .font(.title2)
                    .foregroundColor(.white)
                OwnerAvatar(rvm: rvm)
                
            } else { //ha még nem töltött be
                ProgressView("adatok betöltése...")
            }
        }
        .navigationTitle(rvm.repoReszletes?.name ?? "Cím")
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(.black)
        .task{
            if(self.repoURL != ""){
                do{
                    rvm.repoURL = self.repoURL
                    try await rvm.fetchRepositoryDetails()
                } catch {
                    print(error)
                }
            }
        }
    }//:body
}
