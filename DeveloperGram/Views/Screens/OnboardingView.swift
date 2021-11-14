//
//  OnboardingView.swift
//  DeveloperGram
//
//  Created by Leandro Gamarra on 10/30/21.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationmode
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
            
            Text("Welcome to DeveloperGram")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.myTheme.purpleColor)
            
            Text("DeveloperGram is the #1 App for posting pictures of your code and sharing them across the world. We are a coding loving commuity and we are happy to have you")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.myTheme.purpleColor)
                .padding()
            
            // MARK: SIGN IN WITH APPLE
            Button(action: {
                SignInWithApple.instance.startSignInWithAppleFlow(view: self)
            }, label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
            })
            
            // MARK: SIGN IN WITH GOOGLE
            Button(action: {
                SignInWithGoogle.instance.startSignInWithGoogleFlow(view: self)
            }, label: {
                HStack {
                    Image(systemName: "globe")
                    
                    Text("Sign In with Google")
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(6)
                .font(.system(size: 19, weight: .medium, design: .default))
            })
            .accentColor(Color.white)
            
            Button(action: {
                presentationmode.wrappedValue.dismiss()
            }, label: {
                Text("Continue as Guest".uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
                    .accentColor(.black)
            })
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.myTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.presentationmode.wrappedValue.dismiss()
        }, content: {
            OnboardingViewPart2(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        })
        .alert(isPresented: $showError, content: {
            return Alert(title: Text("Error Signing in 😩"))
        })
    }
    
    // MARK: FUNCTIONS
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential) {
        AuthService.instance.logInUserToFirebase(credential: credential) { (returnedProviderID, isError, isNewUser, returnedUserID) in
            
            if let newUser = isNewUser {
                if newUser {
                    //New user
                    if let providerID = returnedProviderID, !isError {
                        //New user, continue to the onboarding Part 2
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        self.showOnboardingPart2.toggle()
                        
                    } else {
                        //ERROR
                        print("Error getting provider ID from log in user to firebase")
                        self.showError.toggle()
                    }
                } else {
                    //Existing user
                    if let userID = returnedUserID {
                        //Success, log into app
                        AuthService.instance.logInUserToApp(userID: userID) { (success) in
                            if success {
                                print("Successful log in, existing user")
                                self.presentationmode.wrappedValue.dismiss()
                            } else {
                                print("Error logging existing user into our app")
                                self.showError.toggle()
                            }
                        }
                    } else {
                        //ERROR
                        print("Error getting user ID from existing user to firebase")
                        self.showError.toggle()
                    }
                }
                
            } else {
                //ERROR
                print("Error getting info from log in user to firebase")
                self.showError.toggle()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
