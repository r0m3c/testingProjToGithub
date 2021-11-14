//
//  PostArrayObject.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 10/28/21.
//

import Foundation
import SwiftUI

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]()
    
    init() {
        print("Fetch from database")
        
        let post1 = PostModel(postID: "", userID: "", username: "Joegreen", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post2 = PostModel(postID: "", userID: "", username: "jessica", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post3 = PostModel(postID: "", userID: "", username: "Emily", caption: "This is a really really long caption. hahahahahha", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        let post4 = PostModel(postID: "", userID: "", username: "Christopher", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        self.dataArray.append(contentsOf: [post1, post2, post3, post4])
    }
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        self.dataArray.append(post)
    }
}
