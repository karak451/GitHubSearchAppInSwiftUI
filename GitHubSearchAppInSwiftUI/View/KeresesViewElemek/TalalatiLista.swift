//
//  TalalatiLista.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 27..
//

import SwiftUI

struct TalalatiLista: View{
    @ObservedObject var kvm: KeresesViewModel
    let width: CGFloat
    
    var body: some View{
        ScrollView(.vertical){
            VStack(){
                if !kvm.talalatiLista.isEmpty{
                    ForEach(kvm.talalatiLista.indices, id: \.self){ i in
                        NavigationLink(destination: ReszletezesView(repoURL: kvm.talalatiLista[i].url)){
                            ListaElemView(kvm: kvm, index: i, width: width)
                        }
                    }
                } else {
                    Text(kvm.feedbackText)
                        .font(.body)
                        .foregroundColor(Color("vilagosSzurke"))
                }
            }
        }
    }
}
