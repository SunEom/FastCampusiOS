//
//  ChattingViewModel.swift
//  KTV
//
//  Created by 엄태양 on 3/12/24.
//

import Foundation

@MainActor class ChattingViewModel {
    
    private let chatSimulator = ChatSimulator()
    var chatReceived: (()->Void)?
    private(set) var messages: [ChatMessage] = []
    
    init() {
        self.chatSimulator.setMessageHandler { [weak self] in
            self?.messages.append($0)
            self?.chatReceived?()
        }
    }
    
    func strat() {
        self.chatSimulator.start()
    }
    
    func stop() {
        self.chatSimulator.stop()
    }
    
    func sendMessage(_ message: String) {
        self.chatSimulator.sendMessage(message)
    }
}
