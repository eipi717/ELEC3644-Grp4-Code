//
//  ContentView.swift
//  Workout
//
//  Created by Nicholas Ho on 29/10/2022.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    //     Control which page as default page.
    @State private var selectedPage = 3
    @State private var reset = UUID()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        //         Use proxy way to reset the page when clicked
        //        avoid the problem that stucking in the sub-view
        let proxy = Binding(get: {selectedPage}, set: {
            if selectedPage == $0 {
                reset = UUID() // reset the page when clicked
            }
            selectedPage = $0
        })
        
        //         TabView: the bottom navigation bar
        //         map to each view
        //        page icon: from SF Symbol
        TabView(selection: proxy) {
            ExpertView()
                .tabItem() {
                    Image(systemName: "person.fill.checkmark")
                    Text("Expert")
                }
                .tag(1)
            
            FindView()
                .tabItem() {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Find")
                }
                .tag(2)
            
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(3)
            
            AddFoodView()
                .tabItem() {
                    Image(systemName: "magnifyingglass")
                    Text("Find Food")
                }
                .tag(4)
            
            SettingView()
                .tabItem() {
                    Image(systemName: "line.3.horizontal")
                    Text("Setting")
                }
                .tag(5)
                .id(reset)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
