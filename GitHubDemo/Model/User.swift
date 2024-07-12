//
//  User.swift
//  GitHubDemo
//
//  Created by Tanay Kumar Roy on 7/12/24.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
}

