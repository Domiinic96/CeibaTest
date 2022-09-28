//
//  CustomTextView.swift
//  CeibaTest
//
//  Created by Luis Santana on 28/9/22.
//

import SwiftUI

struct CustomTextView: View {
    let name: String
    var body: some View {
        Text(name).font(.system(size: 12, weight: .semibold, design: .default))
    }
}

struct CustomTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextView(name: "test")
    }
}
