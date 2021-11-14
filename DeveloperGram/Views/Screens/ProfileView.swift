//
//  ProfileView.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 10/29/21.
//

import SwiftUI

struct ProfileView: View {
    
    var posts = PostArrayObject()
    @State var profileDisplayName: String
    var profileUserID: String
    var isMyProfile: Bool
    @State var showSettings: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            ProfileHeaderView(profileDisplayName: $profileDisplayName)
            
            ImageGridView(posts: posts)
        }
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                .accentColor(colorScheme == .light ? Color.myTheme.purpleColor : Color.myTheme.yellowColor)
                                .opacity(isMyProfile ? 1.0 : 0.0)
        )
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
                .preferredColorScheme(colorScheme)
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profileDisplayName: "Joe", profileUserID: "", isMyProfile: true)
        }
    }
}
