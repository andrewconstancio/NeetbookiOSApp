//
//  ContentView.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/9/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @AppStorage("Log_Status") var log_Status = false
    
    var body: some View {
        if log_Status {
            TabView {
                NavigationView {
                    CurrentlyReadingView()
                }
                .tabItem {
                    Text("Reading")
                }
                NavigationView {
                    WantToReadView()
                }
                .tabItem {
                    Text("Want To Read")
                }
                NavigationView {
                    ReadView()
                }
                .tabItem {
                    Text("Read")
                }
            }
        } else {
            LoginPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

