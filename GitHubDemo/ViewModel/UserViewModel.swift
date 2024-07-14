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
    
    func fetchUsers() {
        NetworkManager.shared.getData(endpoint: .users, type: User.self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.hasLoaded = true
                case .failure(let error):
                    print("Error fetching users: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
    
}

