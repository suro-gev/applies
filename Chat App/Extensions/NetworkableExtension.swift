//
//  NetworkableExtension.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/5/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

extension Networkable {

    func objects<T: FirestoreCodable>(object: T.Type, parameters: (String, Any)?, completion: @escaping CompletionValues<T>){
        if let par = parameters {
            Firestore.firestore().collection(T.reference()).whereField(par.0, isEqualTo: par.1).getDocuments(completion: { (snapshot, _) in
                var objects = [T]()
                snapshot?.documents.forEach({ (document) in
                    if let element = T.init(document.data()) {
                        objects.append(element)
                    }
                })
                completion(objects)
            })
        } else {
            Firestore.firestore().collection(T.reference()).getDocuments(completion: { (snapshot, _) in
                var objects = [T]()
                snapshot?.documents.forEach({ (document) in
                    if let element = T.init(document.data()) {
                        objects.append(element)
                    }
                })
                completion(objects)
            })
        }
    }
    
    
    
    func create<T: FirestoreCodable>(object: T, completion: @escaping (Bool) -> Void) {
        if let obj = object as? FirestorageCodable, let image = obj.profilePic, let data = UIImagePNGRepresentation(image) {
            
            let ref = Storage.storage().reference().child(type(of: obj).reference()).child(obj.id).child(obj.id + ".png")
            ref.putData(data, metadata: nil) { (metadata, error) in
                guard error == nil else {
                    Firestore.firestore().collection(T.reference()).document(obj.id).setData(obj.mappedData(), merge: true) { (error) in
                        if error == nil {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                    return
                }
                ref.downloadURL(completion: { (url, _) in
                    obj.profilePicLink = url?.absoluteString
                    Firestore.firestore().collection(T.reference()).document(obj.id).setData(obj.mappedData(), merge: true) { (error) in
                        if error == nil {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                })
            }
            
        } else {
            Firestore.firestore().collection(type(of: object).reference()).document(object.id).setData(object.mappedData(), merge: true) { (error) in
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    
    func delete<T: FirestoreCodable>(object: T, completion: @escaping (Bool) -> Void) {
        var ref: String = ""
        if let obj = object as? FirestorageCodable {
            ref = type(of: obj).reference()
        } else {
            ref = type(of: object).reference()
        }
            Firestore.firestore().collection(ref).document(object.id).delete { error in
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
}
