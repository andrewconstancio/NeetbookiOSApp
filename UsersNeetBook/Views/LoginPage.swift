//
//  LoginPage.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/9/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginPage: View {
    
    @State var isLoading: Bool = false
    @AppStorage("Log_Status") var log_Status = false
    
    var body: some View {
        VStack {
            Button(action: {handleLogin()}, label: {
                HStack {
                    Image("google")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                    
                    Text("Sign in with Google")
                        .font(.title3)
                        .fontWeight(.medium)
                        .kerning(1.1)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .strokeBorder()
                )
            })
        }
        .padding()
        .overlay(
            ZStack {
                if isLoading {
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    ProgressView()
                        .font(.title3)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
    }
    
    func handleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController())
        {[self] user, error in

        if let error = error {
            isLoading = false
          print(error.localizedDescription)
        return
        }

        guard
        let authentication = user?.authentication,
        let idToken = authentication.idToken
        else {
            isLoading = false
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { result, err  in
            
            isLoading = false
        
            if let error = error {
                print(error.localizedDescription)
              return
            }
            
            print(result?.user.displayName)
            
            withAnimation{
                log_Status = true
            }
        }
    }}
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }

}

extension View {
    func getRootViewController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
