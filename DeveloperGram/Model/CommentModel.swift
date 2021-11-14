//
//  CommentModel.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 10/29/21.
//

import Foundation
import SwiftUI

struct CommentModel: Identifiable, Hashable {
    var id = UUID()
    var commentID: String // ID for comment in database
    var userID: String // ID for the user in the database
    var username: String // Username for the user in the database
    var content: String // Actual comment text
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
