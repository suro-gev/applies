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
        var conversations = [Conversation]()
        objects(object: Conversation.self, parameters: ("userID", id)) { result in
            conversations.append(contentsOf: result)
            self.objects(object: Conversation.self, parameters: ("secondUserID", id), completion: { result in
                conversations.append(contentsOf: result)
                completion(conversations)
            })
        }
    }
    
    func newConversation(userID: String, completion: @escaping (Bool, Conversation?) -> Void) {
        guard let id = UserManager().currentID() else {
            completion(false, nil)
            return
            
        }
        didConversationExist(with: userID) { (result) in
            if result {
                completion(false, nil)
                return
            } else {
                let conversation = Conversation()
                conversation.userID = id
                conversation.secondUserID = userID
                self.create(object: conversation) { (response) in
                    completion(response, conversation)
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
