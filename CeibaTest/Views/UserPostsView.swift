//
//  UserPosts.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import SwiftUI

struct UserPostsView: View {
    
    let user: UserModel
    @ObservedObject var postsViewModel = PostsViewModel()
    
    init(_ user: UserModel) {
        self.user = user
        self.searchPosts(id: user.id)
    }
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                HStack{
                ImageView(imageName: "person")
                Text(user.name).font(.system(size: 18, weight: .semibold, design: .default))
                }
                HStack{
               ImageView(imageName: "envelope.fill")
                Text(user.email).font(.system(size: 18, weight: .semibold, design: .default))
                }
                HStack{
                ImageView(imageName: "phone.fill")
                Text(user.phone).font(.system(size: 18, weight: .semibold, design: .default))
                }
            }
                
                ScrollView{
                    
                    ForEach(postsViewModel.usersPots, id: \.id) { post in
                        
                        
                        VStack{
                          
                            Text(post.title)
                                .bold()
                                .padding()
                            
                            Text(post.body)
                                .padding()
                        }.padding()
                            .frame(width: Constants.screenSize.width * 0.9)
                            .background(Color.white)
                            .clipped()
                            .padding()
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                            
                    }
                }
        }.overlay(postsViewModel.usersPots.isEmpty ? AnyView(ProgressView2()) : AnyView(EmptyView()))
        .navigationTitle("Publicaciones")
        
    }
    
    private func searchPosts(id: Int){
        
        postsViewModel.getPosts(forUser: id)
    }
}

struct UserPostsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let geo = Geo(lat: "1028288", lng: "768683")
        let address = Address(street: "25", suite: "10", city: "Santo Domingo", zipcode: "12002", geo: geo)
        let company = Company(name: "Luis", catchPhrase: "hola", bs: "hghg")
        let user = UserModel(id: 7, name: "Luis", username: "Luis", email: "Luis@luis.com", address: address , phone: "8899849894", website: "dhsbhjbv.com", company: company)
        UserPostsView(user)
    }
}

