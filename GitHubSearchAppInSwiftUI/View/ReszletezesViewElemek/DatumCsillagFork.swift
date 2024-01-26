//
//  DatumCsillagFork.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 27..
//

import SwiftUI

struct DatumCsillagFork: View{
    @ObservedObject var rvm: ReszletezesViewModel
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Létrehozva: ")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text(datumAtalakitva(gitHubDatum: rvm.repoReszletes!.created_at))
                    .foregroundColor(.white)
                    .italic()
            }.frame(alignment: .leading)
            
            HStack{
                Text("Legutóbb frissítve: ")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text(datumAtalakitva(gitHubDatum: rvm.repoReszletes!.updated_at))
                    .foregroundColor(.white)
                    .italic()
            }.frame(alignment: .leading)
            
            HStack{
                
                HStack(alignment: .center){
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text(String(rvm.repoReszletes!.stargazers_count))
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.bold)
                }
                
                HStack(alignment: .center){
                    Image(systemName: "tuningfork")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text(String(rvm.repoReszletes!.forks_count))
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.bold)
                }
                
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color("sotetSzurke"))
        .cornerRadius(10)
    }
}
