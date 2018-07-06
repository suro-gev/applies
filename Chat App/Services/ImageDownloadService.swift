//
//  ImageDownloadService.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/5/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class ImageDownloadService {
    
    func download(url: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = url else { completion(nil); return }
        guard let downloadURL = URL(string: urlString) else { completion(nil); return }
        let donwloadTask = URLSession.shared.dataTask(with: downloadURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let imageData = data else { completion(nil); return }
                let image = UIImage.init(data: imageData)
                completion(image)
            }
        }
        donwloadTask.resume()
    }
}

