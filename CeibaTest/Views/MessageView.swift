//
//  MessageView.swift
//  CeibaTest
//
//  Created by Luis Santana on 9/9/22.
//

import SwiftUI

struct MessageView: View {
    let message: String
    var body: some View {
        Text(message)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "Alert")
    }
}
