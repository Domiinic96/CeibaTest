//
//  ImageView.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import SwiftUI

struct ImageView: View {
    let imageName: String
    var body: some View {
        Image(systemName: imageName).foregroundColor(Constants.appColor)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageName: Constants.personImageName)
    }
}
