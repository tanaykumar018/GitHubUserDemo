//
//  SwiftUIView.swift
//  GitHubDemo
//
//  Created by Tanay Kumar Roy on 7/12/24.
//

import SwiftUI

struct UserDetailView: View {
    let url: URL
    let username: String
    @State private var isLoading = false

    var body: some View {
        ZStack {
            WebView(url: url, isLoading: $isLoading)
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
            }
        }
        .navigationBarTitle(Text(username), displayMode: .inline)
    }
}
