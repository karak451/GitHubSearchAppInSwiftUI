//
//  KeresesViewModel.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 26..
//

import SwiftUI
import Combine

class KeresesViewModel: ObservableObject{

    @Published var keresoMezoQuery: String = ""
    @Published var minositoMezoQuery: String = ""
    @Published var talalatiLista: [Repository] = []
    private var cancellables = Set<AnyCancellable>()
    
    //UI-hoz kondíciók
    @Published var keresesStatusz: KeresesStatusz = .off
    @Published var feedbackText = ""
    @Published var logoAsFeedback = "GitHubLogo"
    
    @MainActor func fetchGitHubRepositories() async throws{
        
        self.keresesStatusz = .keres
        var standardizedQuery = keresoMezoQuery
        standardizedQuery = standardizedQuery.replacingOccurrences(of: " ", with: "+")
        if !minositoMezoQuery.isEmpty{
            standardizedQuery.append("+language:\(minositoMezoQuery.replacingOccurrences(of: " ", with: "+"))")
        }

        let urlString = "https://api.github.com/search/repositories?q=\(standardizedQuery)"
        
        WebServiceManager.shared.getData(endpoint: urlString, type: Root.self)
            .sink{ completion in
                switch completion{
                case .failure(let err):
                    self.keresesStatusz = .hiba
                    print("Error is \(err.localizedDescription)")
                case .finished: self.keresesStatusz = .vegzett
                }
            } receiveValue: { [weak self] gitHubResponse in
                self?.keresesStatusz = .vegzett
                self?.talalatiLista = gitHubResponse.items
                if (self?.talalatiLista.isEmpty ?? true){
                    self?.logoAsFeedback = "GitHubLogoSemmi"
                    self?.feedbackText = "Próbálkozz más kulcsszóval!"
                } else {
                    self?.logoAsFeedback = "GitHubLogo"
                }
            }.store(in: &cancellables)
    }
}
