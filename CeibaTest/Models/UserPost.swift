//
//  UserPost.swift
//  CeibaTest
//
//  Created by Luis Santana on 26/8/22.
//

import Foundation

struct UserPost: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
