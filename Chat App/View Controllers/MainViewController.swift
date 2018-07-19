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
        
        tableView.refreshControl = refreshControl
        ThemeService().showLoading(true, "Loading conversations...")
        manager.fetchAllConversations { (result) in
            self.conversations = result
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            UserManager().logout()
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
//        alert.preferredAction = cancelAction
        present(alert, animated: true)
    }
    
    @IBAction func showContacts(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "contactsViewController") as! ContactsViewController
        vc.delegate = self
        present(vc, animated: true, completion:  nil)
    }
    
    func didSelectUser(with id: String) {
        ThemeService().showLoading(true, "Creating conversation...")
        manager.newConversation(userID: id) { [weak self] (result, conversation) in
            ThemeService().showLoading(false)
            if result {
                self?.conversations.append(conversation!)
                self?.tableView.reloadData()
            } else {
                var name: String = ""
                self?.manager.objects(object: User.self, parameters: ("id", id), completion: {users  in
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



extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
 
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let secondId = (conversations[index].userID == UserManager().currentID()) ? conversations[index].secondUserID : conversations[index].userID
        
        manager.objects(object: User.self, parameters: ("id", secondId as Any), completion:  { result in
            cell?.textLabel?.text = result.first?.name
            cell?.imageView?.layer.cornerRadius = 30
            cell?.imageView?.frame.size = CGSize(width: 60, height: 60)
            cell?.imageView?.frame.origin = CGPoint(x: 5, y: 5)
            cell?.imageView?.clipsToBounds = true
            cell?.imageView?.image = #imageLiteral(resourceName: "user_image")
            if index == self.conversations.count - 1 {
                ThemeService().showLoading(false)
            }
            
            ImageDownloadService().download(url: result.first?.profilePicLink, completion: { image in
                cell?.imageView?.image = image
            })
        })
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        ThemeService().showLoading(true)
        if editingStyle == UITableViewCellEditingStyle.delete {
            manager.delete(object: conversations[indexPath.row]) { [weak self] result in
                if result {
                    self?.conversations.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .fade)
                    ThemeService().showLoading(false)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Here is the ID of the chat with \(String(describing: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!))", message: "\(conversations[indexPath.row].id)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        manager.fetchAllConversations {[weak self] result in
            self?.conversations = result
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
}
