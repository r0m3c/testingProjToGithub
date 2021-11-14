//
//  PostModel.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 10/28/21.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    var id = UUID()
    var postID: String // ID for the post in database
    var userID: String // ID for the uder in database
    var username: String // Username of user in database
    var caption: String?
    var dateCreated: Date
    var likeCount: Int
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
