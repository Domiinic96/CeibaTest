//
//  UserViewModel.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import Foundation


class UserViewModel: ObservableObject {
    
    @Published var users: [UserModel] = [UserModel]()
    private let webservice = WebService()
    
    init() {
        getUsers()
    }
    
    private func getUsers(){
        
        guard let _ = UserDefaults.standard.value(forKey: "userData") else{
            webservice.getUsers { users, error in
                
                if let users = users, error == nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        do {
                            try self.saveUsersInfo(value: users)
                        } catch  {
                            print(error)
                        }
                        return
                    }
                    
                }
            }
            return
        }
        getUserinfo()
    }
    
    private func saveUsersInfo(value: [UserModel]) throws {
        print(value)
        do {
            let placesData =  try JSONEncoder().encode(value)
            UserDefaults.standard.set(placesData, forKey: "userData")
            getUserinfo()
        } catch  {
            print(error)
        }
    }
    
    private func getUserinfo()  {
        guard let orderData = UserDefaults.standard.data(forKey: "userData") else { return }
       
        do {
            self.users = try JSONDecoder().decode([UserModel].self, from: orderData)
        } catch  {
            print(error)
        }
    }

}


    

