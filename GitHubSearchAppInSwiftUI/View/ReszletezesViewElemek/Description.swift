//
//  Description.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 27..
//

import SwiftUI

struct Description: View{
    @ObservedObject var rvm: ReszletezesViewModel
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Leírás:")
                .font(.title2)
                .foregroundColor(.white)
            Text(rvm.repoReszletes!.description ?? "")
                .foregroundColor(.white)
            
            HStack{
                Image(systemName: "link")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                Text("Ugrás a repository-hoz")
                    .foregroundColor(.white)
                    .onTapGesture {
                        let _ = print("katt")
                        if let url = URL(string: rvm.repoReszletes!.html_url),UIApplication.shared.canOpenURL(url){
                            UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                            })}
                    }
            }
        }.padding(10)
    }
}
