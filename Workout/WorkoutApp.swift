//
//  WorkoutApp.swift
//  Workout
//
//  Created by Nicholas Ho on 29/10/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


class AuthManager : ObservableObject {
    @Published var isLoggedIn = false
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        FirebaseApp.configure() // read the goole info
        authStateHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
        }
    }
}

@main
struct WorkoutApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            if authManager.isLoggedIn{
                // if user has login move to home view
                ContentView().environmentObject(databaseModel())
            }else{
                // if not move to login view
                LogInView()
            }
            
        }
    }
    
}
