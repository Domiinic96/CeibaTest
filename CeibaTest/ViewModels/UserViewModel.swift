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
        
        guard let _ = UserDefaults.standard.value(forKey: Constants.key) else{
            webservice.getUsers { users, error in
                if let users = users, error == nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        do {
                            try self.saveUsersInfo(value: users)
                        } catch  {
                            print(error.localizedDescription)
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
        do {
            let placesData =  try JSONEncoder().encode(value)
            UserDefaults.standard.set(placesData, forKey: Constants.key)
            getUserinfo()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    private func getUserinfo()  {
        guard let orderData = UserDefaults.standard.data(forKey: Constants.key) else { return }
       
        do {
            self.users = try JSONDecoder().decode([UserModel].self, from: orderData)
        } catch  {
            print(error.localizedDescription)
        }
    }

}


    

