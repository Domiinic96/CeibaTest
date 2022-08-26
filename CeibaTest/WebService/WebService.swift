//
//  WebService.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import Foundation

class WebService{
    
    func getUsers(completion: @escaping ([UserModel]?, Error?) -> Void){
        
        var users: [UserModel] = [UserModel]()
        
        guard let url = URL(string: Constants.usersUrl) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse {
                
                if response.statusCode >= 200 && response.statusCode <= 299{
                    
                    if let data = data {
                        do {
                            let userResult =   try JSONDecoder().decode([UserModel].self, from: data)
                            
                            users = userResult
                            completion(users, nil)
                        } catch let error as NSError {
                            print( error.localizedDescription)
                            completion(nil, error)
                        }
                    }
                }
            }
        }.resume()
    }
    
    
    func getPost(completion: @escaping ([UserPost]?, Error?) -> Void){
        
        var usersPosts: [UserPost] = [UserPost]()
        
        guard let url = URL(string: Constants.urlPost) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse {
                
                if response.statusCode >= 200 && response.statusCode <= 299{
                    
                    if let data = data {
                        do {
                            let userPostResult =   try JSONDecoder().decode([UserPost].self, from: data)
                            usersPosts = userPostResult
                            completion(usersPosts, nil)
                        } catch let error as NSError {
                            print( error.localizedDescription)
                            completion(nil, error)
                        }
                    }
                }
            }
        }.resume()
    }
    
    func getPost(forUser userId: Int, completion: @escaping ([UserPost]?, Error?) -> Void){
        
        var usersPosts: [UserPost] = [UserPost]()
        
        guard let url = URL(string: Constants.urlPostFilter + "\(userId)") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse {
                
                if response.statusCode >= 200 && response.statusCode <= 299{
                    
                    if let data = data {
                        do {
                            let userPostResult =   try JSONDecoder().decode([UserPost].self, from: data)
                            usersPosts = userPostResult
                            completion(usersPosts, nil)
                        } catch let error as NSError {
                            print( error.localizedDescription)
                            completion(nil, error)
                        }
                    }
                }
            }
        }.resume()
    }
}
