//
//  PostsViewModel.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import Foundation

class PostsViewModel: ObservableObject{
    @Published var usersPots: [UserPost]
    private let webservice: WebService
    
    init() {
        usersPots = [UserPost]()
        webservice = WebService()
    }
    
    func getPosts(forUser userId: Int){
        
        webservice.getPost(forUser: userId) { posts, error in
            if let posts = posts, error == nil {
                DispatchQueue.main.async {
                    self.usersPots = posts
                }
            }
        }
    }
}
