//
//  SettingView.swift
//  Workout
//
//  Created by Nicholas Ho on 12/11/2022.
//

import SwiftUI
import FirebaseAuth

struct SettingView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    HStack {
                        Spacer();
                        Button(action: {
                            print("HEllo Clicked!")
                        }, label: {
                            VStack{
                                Image(systemName: "person.circle")
                                    .font(.system(size: 70))
                                Text(Auth.auth().currentUser!.email ?? "").padding()
                            }
                        })
                        Spacer()
                    }
                    
                }
                .listRowBackground(Color.clear)
                .padding(-10)
                
                Section(header: Text("")) {
                    NavigationLink(destination: AppAppearanceView()) {
                        Button(action: {
                            
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "moon.circle.fill")
                                    .font(.system(size: 20))
                                Text("App Appearance")
                            }
                        }
                    }
                    // no language view yet
                    //                    NavigationLink(destination: LanguageView()) {
                    //                        Button(action: {
                    //
                    //                        }) {
                    //                            HStack(alignment: .center) {
                    //                                Image(systemName: "a.square.fill")
                    //                                    .font(.system(size: 20))
                    //                                Text("Language")
                    //                            }
                    //                        }
                    //                    }
                }
                
                Section(header: Text("")) {
//                    Button(action: {
//
//                    }) {
//                        HStack(alignment: .center) {
//                            Image(systemName: "fork.knife.circle.fill")
//                                .font(.system(size: 20))
//                            Text("Saved Food")
//                        }
//                    }
                    NavigationLink(destination: SavedLocationView()){
                        Button(action: {
                            
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "globe")
                                    .font(.system(size: 20))
                                Text("Saved Location")
                                
                            }
                        }
                    }
                }
                
//                Section(header: Text("")) {
//                    Button(action: {
//                        
//                    }) {
//                        HStack(alignment: .center) {
//                            Image(systemName: "lock.circle.fill")
//                                .font(.system(size: 20))
//                            Text("Privacy Setting")
//                        }
//                    }
//                    
//                    Button(action: {
//                        
//                    }) {
//                        HStack(alignment: .center) {
//                            Image(systemName: "trophy.circle.fill")
//                                .font(.system(size: 20))
//                            Text("Your Goal")
//                        }
//                    }
//                }
                
                Section(header: Text("")){
                    Button(action:{
                        let firebaseAuth = Auth.auth()
                        do{
                            try firebaseAuth.signOut()
                        }catch _ as NSError{
                            print("Error signing out")
                        }
                    }){
                        HStack(alignment: .center) {
                            Text("Logout")
                        }
                    }
                }
                .navigationTitle(Text("Setting"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    struct SettingView_Previews: PreviewProvider {
        static var previews: some View {
            SettingView()
        }
    }
}
