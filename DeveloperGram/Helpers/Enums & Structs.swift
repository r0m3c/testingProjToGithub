//
//  Enums & Structs.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 11/2/21.
//

import Foundation


struct DatabaseUserField { // Fields within user document in database
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
}

struct CurrentUserDefaults { // Fields for UserDefaults saved within app
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
}
