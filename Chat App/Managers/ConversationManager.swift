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
        let conversation = Conversation()
        conversation.userID = id
        conversation.secondUserID = userID
        create(object: conversation) { (response) in
            completion(response)
        }
    }
}
