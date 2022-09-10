//
//  UserViewModel.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import Foundation
import SwiftUI


class UserViewModel: ObservableObject {
  
    @Published var users: [UserModel] = [UserModel]()
    private let webservice = WebService()
    @Published var error2: Error?
    @Published var isProgressing: Bool = false
    @Published var presentAlert: Bool = false
    
    init() {
        getUsers()
    }
    
    func getUsers(){
        
        self.isProgressing = true
        self.presentAlert = false
        guard let _ = UserDefaults.standard.value(forKey: Constants.key) else{
            webservice.getUsers { users, error in
                if let users = users {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        do {
                            try self.saveUsersInfo(value: users)
                        } catch  {
                            print(error.localizedDescription)
                        }
                        return
                    }
                }
                
                if let error = error{
                    DispatchQueue.main.async {
                        self.isProgressing = false
                        self.presentAlert = true
                        self.error2 = error
                    }
                    
                }
            }
            return
        }
        getUserinfo()
    }
    
    private func saveUsersInfo(value: [UserModel]) throws {
        do {
            let placesData =  try JSONEncoder().encode(value)
            UserDefaults.standard.set(placesData, forKey: Constants.key)
            getUserinfo()
        } catch let err as NSError {
            self.error2 = err
        }
    }
    
    private func getUserinfo()  {
        guard let orderData = UserDefaults.standard.data(forKey: Constants.key) else { return }
       
        do {
            self.users = try JSONDecoder().decode([UserModel].self, from: orderData)
            self.isProgressing = false
            self.presentAlert = false
            self.error2 = nil
        } catch let err as NSError {
            self.error2 = err
        }
    }

}


    

