//
//  Model.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 26..
//

import Foundation


enum KeresesStatusz{
    case keres
    case hiba
    case vegzett
    case off
}

//MARK: listázáshoz
struct Root: Codable{
    let items: [Repository]
}

struct Repository: Codable{
    let name, url, updated_at: String
    let description: String?
    let stargazers_count: Int
}

//MARK: részletes nézethez
struct RepositoryReszletes: Codable{
    let name: String
    let description: String?
    let owner: Owner
    let html_url: String
    let stargazers_count: Int
    let forks_count: Int
    let created_at: String
    let updated_at: String
}

struct Owner: Codable{
    let login: String
   // let name: String
    let avatar_url: String
    let html_url: String
}


