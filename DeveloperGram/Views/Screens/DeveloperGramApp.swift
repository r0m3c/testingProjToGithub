//
//  DeveloperGramApp.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 10/28/21.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct DeveloperGramApp: App {
    
    init() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID  = FirebaseApp.app()?.options.clientID
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance().handle(url) // For google sign in
                })
        }
    }
}
