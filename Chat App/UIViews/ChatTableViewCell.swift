//
//  ChatTableViewCell.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/18/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatIDLabel: UILabel!
    
    let spinner = UIActivityIndicatorView()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    func set(with userData: User, and chatID: String) {
        userImageView.layer.cornerRadius = 83 / 2
        userImageView.clipsToBounds = true
        spinner.center = userImageView.center
        addSubview(spinner)
        spinner.startAnimating()
        chatIDLabel.text = chatID
        nameLabel.text = userData.name
        ImageDownloadService().download(url: userData.profilePicLink) { [weak self] image in
            self?.userImageView.image = image
            self?.spinner.stopAnimating()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
