//
//  ContentView.swift
//  GitHubDemo
//
//  Created by Tanay Kumar Roy on 7/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(url: URL(string: user.html_url)!, username: user.login)) {
                            HStack {
                                if let avatarURL = URL(string: user.avatar_url) {
                                    AsyncImage(url: avatarURL) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(user.login)
                                        .font(.headline)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .navigationTitle("GitHub Users")
                    .onAppear {
                        viewModel.fetchUsers()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

