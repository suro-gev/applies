//
//  ContactCollectionViewCell.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/3/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    override func awakeFromNib() {
//        userImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 35)
//        userNameLabel.frame = CGRect(x: Int(userImageView.frame.height + 15), y: 0, width: Int(self.frame.width), height: 15)
        activityIndicator.center = userImageView.center
    }
    
    func set(_ user: User?) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        userNameLabel.text = user?.name
        ImageDownloadService().download(url: user?.profilePicLink) { [weak self] image in
            self?.userImageView.image = image
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
}
