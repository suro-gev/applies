//
//  ImagePickerService.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/5/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit
import Photos

class ImagePickerService: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private let picker = UIImagePickerController()
    var closure: (UIImage?) -> Void  = { _ in }
    
    func pick(from vc: UIViewController?, completion: @escaping (UIImage?) -> Void) {
        closure = completion
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        vc?.present(picker, animated: true, completion: nil)
        completion(nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            closure(image)
        } else {
            closure(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
