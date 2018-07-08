//
//  ContactsViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/3/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

protocol ContactsViewControllerDelegate {
    func didSelectUser(with id: String)
}

class ContactsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: ContactsViewControllerDelegate?
    let manager = UserManager()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.allUsers { [weak self] (users) in
            self?.users = users
            self?.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContactCollectionViewCell
        cell.set(users[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 3
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectUser(with: users[indexPath.row].id)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
