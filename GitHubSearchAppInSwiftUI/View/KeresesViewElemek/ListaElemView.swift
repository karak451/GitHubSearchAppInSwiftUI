//
//  ListaElem.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 26..
//

import SwiftUI

struct ListaElemView: View{
    @ObservedObject var kvm: KeresesViewModel
    let index: Int
    let width: CGFloat
    
    var body: some View{
        HStack{
            
            VStack(alignment: .center){
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text(String(kvm.talalatiLista[index].stargazers_count))
                    .foregroundColor(Color("sotetSzurke"))
                    .font(.footnote)
                    .fontWeight(.bold)
            }.frame(width: width*0.15)
            
            Divider()
            
            VStack(alignment: .leading){
                Text(kvm.talalatiLista[index].name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("sotetSzurke"))
                Text(kvm.talalatiLista[index].description ?? "(nincs leírás)")
                    .font(.body)
                    .foregroundColor(Color("sotetSzurke"))
                HStack{
                    Text("legutóbb módosítva:")
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.gray)
                    
                    Text(datumAtalakitva(gitHubDatum: kvm.talalatiLista[index].updated_at))
                        .font(.footnote)
                        .foregroundColor(Color("sotetSzurke"))
                }
                
            }.frame(width: width*0.8)
            
        }
        .padding(5)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
        .background(Color("vilagosSzurke").opacity(0.9))
        .cornerRadius(10)
    }
}
