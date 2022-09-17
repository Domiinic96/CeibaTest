//
//  ContentView.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import SwiftUI

struct ContentView: View {
    let appearance = UINavigationBarAppearance()
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    @State var searchTerm = ""
    
    
    init(){
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.09093337506, green: 0.3101809025, blue: 0.06622100621, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
    var body: some View {
        
        let resultList = searchTerm.isEmpty ? userViewModel.users : userViewModel.users.filter({ $0.name.localizedCaseInsensitiveContains(searchTerm)})
        
        return NavigationView{
            VStack{
                serchView.offset(y: resultList.isEmpty ? Constants.screenSize.height * -0.36 : 0)
                
                if resultList.isEmpty {
                    listEmptyMessage
                }else{
                    ScrollView{
                        ForEach(resultList, id: \.id){ user in
                            HStack{
                                VStack(alignment:.leading){
                                    Text(user.name)
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                        .foregroundColor(Constants.appColor)
                                    HStack{
                                        ImageView(imageName: Constants.phoneImageName)
                                        Text(user.phone)
                                            .font(.system(size: 15, weight: .regular, design: .default))
                                    }
                                    
                                    HStack{
                                        ImageView(imageName: Constants.letterImageName)
                                        Text(user.email)
                                            .font(.system(size: 15, weight: .regular, design: .default))
                                    }
                                }
                                Spacer()
                                VStack{
                                    Spacer()
                                    NavigationLink {
                                        UserPostsView(user)
                                    } label: {
                                        Text(Constants.watchPosts)
                                            .font(.system(size: 10))
                                            .foregroundColor(Constants.appColor)
                                    }.padding(5)
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Constants.appColor, lineWidth: 1))
                                    
                                        
                                }
                            }.padding()
                                .background(.white)
                                .cornerRadius(10)
                                .frame(width: Constants.screenSize.width * 0.9, height: Constants.screenSize.height * 0.15)
                                .clipped()
                                .shadow(color: .black, radius: 2, x: 0, y: 0)
                                .padding()
                                .animation(Animation.spring().speed(0.2), value: self.searchTerm)
                                
                                
                               
                        }
                    }
                }
            }.frame(alignment: .top)

                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                        MessageView(message:Constants.navigationBarTittle).foregroundColor(Color.white)
                    })
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing, content: {
                        reloadButton2
                    })
                })
                .overlay(!self.userViewModel.isProgressing  ? AnyView(EmptyView()) : AnyView(ProgressView2()))
                .overlay(self.userViewModel.presentAlert ? AnyView(Text("\(userViewModel.error2!.localizedDescription.description)")) : AnyView(EmptyView()))
                .alert(Text(Constants.error), isPresented: self.$userViewModel.presentAlert) {
                    
                    MessageView(message:self.userViewModel.error2?.localizedDescription ?? "")
                    
                    okButton
                    
                    reloadButton

                } message: {
                    MessageView(message:self.userViewModel.error2?.localizedDescription ?? "")
                }
        }
    }
        
    
    var okButton: some View{
        Button {
            
        } label: {
            Text(Constants.OK)
        }
    }
    
    var reloadButton: some View{
        Button {
            self.userViewModel.getUsers()
        } label: {
            Text(Constants.RELOAD)
        }
    }
    
    var reloadButton2: some View{
        Button {
            self.userViewModel.getUsers()
        } label: {
            Image(systemName: Constants.reloadIcon)
                .foregroundColor(.white)
        }.disabled(!self.userViewModel.users.isEmpty)
            .opacity(!self.userViewModel.users.isEmpty ? 1 : 0.5)
    }
    
    var serchView: some View{
        VStack(alignment:.leading){
            Text(Constants.searchUser)
                .foregroundColor(Constants.appColor)
                .font(.system(size: 15))
        TextField("", text: $searchTerm)
        
        Rectangle().fill(Constants.appColor)
            .frame(width: nil, height: 1)
        }.padding(20)
    }
    
    var listEmptyMessage: some View{
        VStack{
            MessageView(message:Constants.emptyList).foregroundColor(Constants.appColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
