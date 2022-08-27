//
//  ContentView.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import SwiftUI

struct ContentView: View {
    let appearance = UINavigationBarAppearance()
    @ObservedObject var userViewModel = UserViewModel()
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
                                        .foregroundColor(Color("appColor"))
                                    HStack{
                                       ImageView(imageName: "phone.fill")
                                        Text(user.phone)
                                    }
                                    
                                    HStack{
                                        ImageView(imageName: "envelope.fill")
                                        Text(user.email)
                                    }
                                    
                                }
                                Spacer()
                                VStack{
                                    Spacer()
                                    NavigationLink {
                                        UserPostsView(user)
                                    } label: {
                                        Text("VER PUBLICACIONES")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color("appColor"))
                                        
                                    }
                                    
                                }
                            }.padding()
                                .background(.white)
                                .frame(width: Constants.screenSize.width * 0.9, height: Constants.screenSize.height * 0.15)
                                .clipped()
                                .shadow(color: .black, radius: 2, x: 0, y: 0)
                                .padding()
                        }
                        
                    }
                }
                
            }.frame(alignment: .top)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                        Text("Prueba de ingreso").foregroundColor(Color.white)
                    })
                })
                .overlay(!self.userViewModel.users.isEmpty ? AnyView(EmptyView()) : AnyView(ProgressView2()))
            
        }
    }
    
    var serchView: some View{
        VStack(alignment:.leading){
        Text("Busar usuario")
                .foregroundColor(Constants.appColor)
                .font(.system(size: 15))
        TextField("", text: $searchTerm)
        
        Rectangle().fill(Constants.appColor)
            .frame(width: nil, height: 1)
        }.padding(20)
    }
    
    var listEmptyMessage: some View{
        VStack{
            Text("List is empty").foregroundColor(Constants.appColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
