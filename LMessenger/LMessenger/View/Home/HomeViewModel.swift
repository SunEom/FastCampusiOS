//
//  HomeViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/19/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum Action {
        case load
        case requestContacts
        case presentMyProfileView
        case presentOthreProfileView(String)
        
    }
    
    @Published var myUser: User?
    @Published var users: [User] = []
    @Published var phase: Phase = .notRequested
    @Published var modalDestination: HomeModalDestination?
    
    private var userId: String
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
            case .load:
                // TODO:
                phase = .loading
                container.services.userService.getUser(userId: userId)
                    .handleEvents (receiveOutput: { [weak self] user in
                        self?.myUser = user
                    })
                    .flatMap { user in
                        self.container.services.userService.loadUsers(id: user.id)
                    }
                    .sink { [weak self] completion in
                        if case .failure = completion {
                            self?.phase = .fail
                        }
                        // TODO:
                    } receiveValue: { [weak self] users in
                        self?.phase = .success
                        self?.users = users
                    }.store(in: &subscriptions)
                
            case .requestContacts:
                self.container.services.contactService.fetchContacts()
                    .flatMap { users in
                        self.container.services.userService.addUserAfterContact(users: users)
                    }
                    .flatMap { _ in
                        self.container.services.userService.loadUsers(id: self.userId)
                    }
                    .sink { [weak self] completion in
                        if case .failure = completion {
                            self?.phase = .fail
                        }
                    } receiveValue: { [weak self] users in
                        self?.phase = .success
                        self?.users = users
                    }.store(in: &subscriptions)
                
            case .presentMyProfileView:
                self.modalDestination = .myProfile
                
            case let .presentOthreProfileView(userId):
                self.modalDestination = .otherProfile(userId)
                
        }
    }
}
