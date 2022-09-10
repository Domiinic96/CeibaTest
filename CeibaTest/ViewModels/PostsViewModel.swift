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
    @Published var error2: NSError?
    @Published var isFetchingData: Bool = false
    @Published var presentAlert: Bool = false
    
    init() {
        usersPots = [UserPost]()
        webservice = WebService()
    }
    
    func getPosts(forUser userId: Int){
        self.isFetchingData = true
        webservice.getPost(forUser: userId) { posts, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isFetchingData = false
                    self.error2 = error as NSError
                    self.presentAlert = true
                }
            }
            
            if let posts = posts {
                DispatchQueue.main.async {
                    self.presentAlert = false
                    self.isFetchingData = false
                    self.usersPots = posts
                   
                    
                }
            }
        }
    }
}
