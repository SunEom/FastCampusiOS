//
//  AuthenticatedView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/18/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticatedViewModel
    
    var body: some View {
        switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
            case .authenticated:
                MainTabView()
        }
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}

