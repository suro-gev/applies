//
//  ChatViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/9/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var contactsColView: UICollectionView!
    @IBOutlet weak var chatsTableView: UITableView!
    
    let userManager = UserManager()
    let conversationManager = ConversationManager()
    var conversations = [Conversation]()
    var users = [User]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThemeService().showLoading(true)
        userManager.allUsers(completion: {[weak self] result  in
            self?.users = result
            self?.contactsColView.reloadData()
            ThemeService().showLoading(false)
        })
        
        conversationManager.fetchAllConversations { [weak self] result in
            self?.conversations = result
            self?.chatsTableView.reloadData()
            ThemeService().showLoading(false)
        }

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: contactsColView.frame.height, height: contactsColView.frame.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        contactsColView.collectionViewLayout = flowLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let secondId = conversations[indexPath.row].secondUserID as Any
        userManager.objects(object: User.self, parameters: ("id", secondId), completion:  { result in
            cell?.textLabel?.text = result.first?.name
        })
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            ThemeService().showLoading(true)
            conversationManager.delete(object: conversations[indexPath.row]) {[weak self] result in
                if result {
                    self?.conversations.remove(at: indexPath.row)
                    self?.chatsTableView.deleteRows(at: [indexPath], with: .fade)
                    ThemeService().showLoading(false)
                }
            }
        }
    }
    
}


extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactCollectionViewCell
        cell.set(users[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ThemeService().showLoading(true)
        
        conversationManager.newConversation(userID: users[indexPath.row].id) {[weak self] (result, conversation) in
            ThemeService().showLoading(false)
            if result {
                self?.conversations.append(conversation!)
                self?.chatsTableView.reloadData()
            } else {
                var name: String = ""
                self?.userManager.objects(object: User.self, parameters: ("id", self?.users[indexPath.row].id as Any), completion: {users  in
                    name = (users.first?.name)!
                    let alert = UIAlertController(title: "Chat already exists!", message: "You have a chat with \(name)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                })
            }

        }
    }
    
    
}
