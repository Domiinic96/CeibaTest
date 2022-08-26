//
//  WebServiceUT.swift
//  CeibaUTTest
//
//  Created by Luis Santana on 26/8/22.
//

import XCTest
@testable import CeibaTest

class WebServiceUT: XCTestCase {
    var webService: WebService?
    var posts: [UserPost]?
    var users: [UserModel]?
    var expectation = XCTestExpectation()
    override func setUpWithError() throws {
        webService = WebService()
        posts = [UserPost]()
        users = [UserModel]()
    }
      

    override func tearDownWithError() throws {
        webService = nil
        posts = nil
    }

    func testGetPostsByUser() throws {
        self.expectation = expectation(description: "posts")
        webService!.getPost(forUser: 1, completion: { posts, error in
            self.posts = posts!
            self.expectation.fulfill()
            XCTAssertTrue(!posts!.isEmpty && error == nil)
        })
        
        waitForExpectations(timeout: 4) { (error) in
            XCTAssertNotNil(self.posts)
         }
    }
    
    func testGetAllUsers() throws{
        self.expectation = expectation(description: "posts")
        webService!.getUsers { users, error in
            self.users = users
            self.expectation.fulfill()
            XCTAssertTrue(!users!.isEmpty && error == nil)
        }
        
        waitForExpectations(timeout: 4) { (error) in
            XCTAssertNotNil(self.users)
         }
    }
    
    func testGetAllPosts() throws{
        self.expectation = expectation(description: "posts")
        webService!.getPost { posts, error in
            self.posts = posts
            self.expectation.fulfill()
            XCTAssertTrue(!posts!.isEmpty && error == nil)
        }
        
        waitForExpectations(timeout: 3) { (error) in
            XCTAssertNotNil(self.posts)
         }
    }
}
