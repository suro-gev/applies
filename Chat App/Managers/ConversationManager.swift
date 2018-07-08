//
//  ConversationManager.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/5/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation

class ConversationManager: Networkable {
    
    func fetchAllConversations(_ completion: @escaping CompletionValues<Conversation>) {
        guard let id = UserManager().currentID() else { completion([Conversation()]); return }
        objects(object: Conversation.self, parameters: ("userID", id)) { results in
            completion(results)
        }
    }
    
    func newConversation(userID: String, completion: @escaping (Bool) -> Void) {
        guard let id = UserManager().currentID() else { completion(false); return }
        didConversationExist(with: userID) { (result) in
            if result {
                completion(false)
                return
            } else {
                let conversation = Conversation()
                conversation.userID = id
                conversation.secondUserID = userID
                self.create(object: conversation) { (response) in
                    completion(response)
                }
            }
        }
    }
    
    private func didConversationExist(with id: String, completion: @escaping (Bool) -> Void) {
        var conversations = [Conversation]()
        self.fetchAllConversations { (result) in
            conversations = result
            
            for conversation in conversations {
                if (conversation.userID == UserManager().currentID() && conversation.secondUserID == id) || (conversation.secondUserID == UserManager().currentID() && conversation.userID == id) {
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
}
