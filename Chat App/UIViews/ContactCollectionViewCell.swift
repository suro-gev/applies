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
            userImageView.layer.cornerRadius = 15
            userImageView.clipsToBounds = true
        }


    func set(_ user: User?) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        userNameLabel.text = user?.name
        ImageDownloadService().download(url: user?.profilePicLink) { [weak self] image in
            user?.profilePic = image
            self?.userImageView.image = user?.profilePic
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
}
