//
//  HomeView.swift
//  Workout
//
//  Created by Nicholas Ho on 12/11/2022.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State var isLogout:Bool = false
    var body: some View {
        NavigationView(){

            TabView {
                ForEach(1..<5) {item in
                    Image("\(item)")
                        .resizable()
                        .scaledToFit()
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            
        }
        


    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
