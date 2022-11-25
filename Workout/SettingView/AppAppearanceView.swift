//
//  AppAppearanceView.swift
//  Workout
//
//  Created by Nicholas Ho on 13/11/2022.
//

import SwiftUI

struct AppAppearanceView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View  {
         NavigationView {
            List{
               HStack{
                     Toggle("Dark Mode", isOn: $isDarkMode)
                   }
             }
        }
      }
    }

struct AppAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppAppearanceView()
    }
}
