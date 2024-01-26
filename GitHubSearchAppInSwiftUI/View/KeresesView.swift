//
//  ContentView.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 26..
//

import SwiftUI

struct KeresesView: View {
    @ObservedObject var kvm = KeresesViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(kvm.logoAsFeedback)
                .resizable()
                .frame(width: 150, height: 150)
            GeometryReader{ geo in
                
                VStack{
                    KeresoMezo(kvm: kvm, width: geo.size.width)
                    
                    Spacer().frame(height: 50)
                    
                    switch kvm.keresesStatusz{
                    case .hiba : Text("hiba a keresés során").foregroundColor(Color("vilagosSzurke"))
                    case .vegzett : TalalatiLista(kvm: kvm, width: geo.size.width)
                    case .keres : ProgressView("keres")
                    default : EmptyView()
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            }//:geometryR
        }
        .navigationTitle("Keresés a GitHubon")
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.black)
        
    }//:body
    
}


