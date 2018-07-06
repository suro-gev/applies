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
    
    
    @IBAction func logOutAction(_ sender: Any) {
        UserManager().logout()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showContacts(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "contactsViewController") as! ContactsViewController
        vc.delegate = self
        present(vc, animated: true, completion:  nil)
    }
    
    func didSelectUser(with id: String) {
        
    }
    
}



extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        return cell!
    }
    
}
