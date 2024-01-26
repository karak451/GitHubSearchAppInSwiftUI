//
//  datumAtalakitva.swift
//  GitHubSearchAppInSwiftUI
//
//  Created by Sudar Istvan on 2024. 01. 27..
//

import Foundation

func datumAtalakitva(gitHubDatum: String) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy. MM. dd. HH:mm"
    
    let date = dateFormatter.date(from: gitHubDatum) ?? Date()
    let dateString = dateFormatter.string(from: date)
    return dateString
}
