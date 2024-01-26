//
//  OwnerAvatar.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 27..
//

import SwiftUI

struct OwnerAvatar: View{
    @ObservedObject var rvm: ReszletezesViewModel
    
    var body: some View{
        HStack(alignment: .top){
            AsyncImage(url: URL(string: rvm.owner!.avatar_url)){ phase in
                switch phase{
                case .empty, .failure: Image(systemName: "person.fill").frame(width: 100, height: 100)
                case .success(let image): image.resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                default: EmptyView().frame(width: 100, height: 100)
                }
            }.frame(width: 100, height: 100).cornerRadius(5)
            
            VStack(alignment: .leading){
                Text(rvm.owner!.login)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color("sotetSzurke"))
                Spacer().frame(height: 30)
                HStack{
                    Image(systemName: "link")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("sotetSzurke"))
                    Text("GitHub profil")
                        .foregroundColor(Color("sotetSzurke"))
                        .onTapGesture {
                            let _ = print("katt")
                            if let url = URL(string: rvm.owner!.html_url),UIApplication.shared.canOpenURL(url){
                                UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                                })}
                        }
                }
            }
        }
        .padding(10)
        .frame(alignment: .leading)
        .background(Color("vilagosSzurke"))
        .cornerRadius(10)
    }
}
