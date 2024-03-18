//
//  AuthenticatedViewModel.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    
    enum Action {
        case googleLogin
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    var userId: String?
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
            case .googleLogin:
                container.services.authService.signInWithGoogle()
                    .sink { completion in
                        // TODO:
                    } receiveValue: { [weak self] user in
                        self?.userId = user.id
                    }.store(in: &subscriptions)
        }
    }
}