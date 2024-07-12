//
//  UserViewModel.swift
//  GitHubDemo
//
//  Created by Tanay Kumar Roy on 7/12/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    private var cancellables: Set<AnyCancellable> = []
    private var hasLoaded = false
    let baseURL = "https://api.github.com/users"

    func fetchUsers() {
        guard !hasLoaded else { return }
        
        isLoading = true
        guard let url = URL(string: baseURL) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.hasLoaded = true
                case .failure(let error):
                    print("Error fetching users: \(error)")
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
}

