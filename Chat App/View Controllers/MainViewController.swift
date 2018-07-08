//
//  MainViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/19/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ContactsViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let manager = ConversationManager()
    var conversations = [Conversation]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MainViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(refreshControl)
        manager.fetchAllConversations { (result) in
            self.conversations = result
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes!", style: .default) { (action) in
            UserManager().logout()
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func showContacts(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "contactsViewController") as! ContactsViewController
        vc.delegate = self
        present(vc, animated: true, completion:  nil)
    }
    
    func didSelectUser(with id: String) {
        manager.newConversation(userID: id) { [weak self] (result) in
            if result {
                self?.manager.fetchAllConversations({ (result) in
                    self?.conversations = result
                    self?.tableView.reloadData()
                })
            } else {
                let alert = UIAlertController(title: "Chat already exists!", message: "You have a chat with the user you chose", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                self?.present(alert, animated: true)
            }
        }
    }
    
}



extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = conversations[indexPath.row].id
        return cell!
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}
