//
//  WebService.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import Foundation

class WebService{
    
    func getUsers(completion: @escaping ([UserModel]?, Error?) -> Void){
        
        ApiClient<UserModel>.fetchListData(url: Constants.usersUrl) { users, error in
            completion(users, error)
        }
    }
    
    func getPost(completion: @escaping ([UserPost]?, Error?) -> Void){
        
        ApiClient<UserPost>.fetchListData(url: Constants.urlPost, completion: { posts, error in
            completion(posts, error)
        })
    }
    
    func getPost(forUser userId: Int, completion: @escaping ([UserPost]?, Error?) -> Void){
        
        ApiClient<UserPost>.fetchListData(url: Constants.urlPostFilter + "\(userId)") { posts, error in
            completion(posts, error)
        }
    }
}
