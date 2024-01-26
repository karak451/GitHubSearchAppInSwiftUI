//
//  KeresoMezo.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 26..
//

import SwiftUI

struct KeresoMezo: View{
    
    @ObservedObject var kvm: KeresesViewModel
    let width: CGFloat
    
    enum Field{
        case keresoSzo
        case minositoSzo
    }
    
    @FocusState private var keresoMezoFocused: Field?
    let keresoMezoMagassag: CGFloat = 45
    @State var reszletes = false
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    VStack{
                        TextField(
                            "",
                            text: $kvm.keresoMezoQuery
                        )
                        .foregroundColor(Color("sotetSzurke"))
                        .frame(width: width*0.7)
                        .padding(10)
                        .autocapitalization(.none)
                        .focused($keresoMezoFocused, equals: .keresoSzo)
                    }
                    .frame(alignment: .leading)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                    
                    Text("Repository keresése")
                        .foregroundColor(Color("sotetSzurke"))
                        .background(Color("vilagosSzurke"))
                        .frame(width: width*0.7, alignment: .leading)
                        .font(.footnote)
                        .offset(y: -20)
                }
                .frame(height: keresoMezoMagassag)
                .padding(5)
                .background(Color("vilagosSzurke"))
                .cornerRadius(5)
                
                Spacer()
                
                Button{
                    Task{
                        do{
                            keresoMezoFocused = nil
                            try await kvm.fetchGitHubRepositories()
                        } catch {
                            print(error)
                        }
                    }
                }  label: {
                    Text("Keress!")
                        .frame(width: width * 0.18, height: keresoMezoMagassag)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(5)
                }
            }//:elso sor
            
            if reszletes {
                HStack{
                    Text("nyelv:")
                        .font(.body)
                        .foregroundColor(Color("vilagosSzurke"))
                    TextField(
                        "",
                        text: $kvm.minositoMezoQuery
                    )
                    .padding(10)
                    .frame(width: width*0.64)
                    .foregroundColor(Color("sotetSzurke"))
                    .background(Color("vilagosSzurke"))
                    .cornerRadius(5)
                    .autocapitalization(.none)
                    .focused($keresoMezoFocused, equals: .minositoSzo)
                    
                    Spacer()
                    
                    Text("elrejt")
                        .font(.body)
                        .foregroundColor(Color("vilagosSzurke"))
                        .onTapGesture {
                            reszletes = false
                        }
                    Spacer()
                }.frame(minWidth: 0, maxWidth: .infinity)
            } else {
                Text("részletes keresés")
                    .font(.body)
                    .foregroundColor(Color("vilagosSzurke"))
                    .onTapGesture {
                        reszletes = true
                    }
            }
        }//:VStack
    }
}
