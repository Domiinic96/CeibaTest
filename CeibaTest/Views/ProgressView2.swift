//
//  ProgressView.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import SwiftUI

struct ProgressView2: View {
    var body: some View {
        VStack{
            ProgressView("Loading")
            .tint(.green)
            
        }.frame(width: 150, height: 150)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 2, x: 0, y: 0)
            
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView2()
    }
}
