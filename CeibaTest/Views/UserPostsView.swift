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
    @Environment(\.presentationMode) var presentationMode
    
    init(_ user: UserModel) {
        self.user = user
    }
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                HStack{
                    ImageView(imageName: Constants.personImageName)
                    Text(user.name).font(.system(size: 12, weight: .semibold, design: .default))
                }
                HStack{
                    ImageView(imageName: Constants.letterImageName)
                    Text(user.email).font(.system(size: 12, weight: .semibold, design: .default))
                }
                HStack{
                    ImageView(imageName: Constants.phoneImageName)
                    Text(user.phone).font(.system(size: 12, weight: .semibold, design: .default))
                }
                
            }.padding()
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Constants.appColor, lineWidth: 1))
            .padding()
                
            if postsViewModel.usersPots.count > 0{
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
                            .cornerRadius(10)
                            .clipped()
                            .padding()
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                            
                    }
                }
            }else{
                
                Spacer()
                Text(postsViewModel.error2?.localizedDescription ?? "")
                Spacer()
            }
            
        }.toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: Constants.reloadIcon)
                    .onTapGesture {
                    self.postsViewModel.getPosts(forUser: user.id)
                    }.foregroundColor(.white)
                    .disabled(!self.postsViewModel.usersPots.isEmpty)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: Constants.backButtonImage)
                    Text("back")
                }.foregroundColor(.white)
            }
        })
        .overlay(postsViewModel.isFetchingData ? AnyView(ProgressView2()) : AnyView(EmptyView()))
            .navigationTitle(Constants.postsNavBarDescription)
            .alert(Text(Constants.error), isPresented: self.$postsViewModel.presentAlert) {
                Text(self.postsViewModel.error2?.localizedDescription ?? "")
                Button {
                    return
                } label: {
                    Text(Constants.OK)
                }
                
                Button {
                    self.postsViewModel.getPosts(forUser: user.id)
                } label: {
                    Text(Constants.RELOAD)
                }


            } message: {
                Text(self.postsViewModel.error2?.localizedDescription ?? "")
            }
            .navigationBarBackButtonHidden(true)
            .onAppear{
                self.postsViewModel.getPosts(forUser: self.user.id)
            }
   
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

