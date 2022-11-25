//
//  AddFoodView.swift
//  Workout
//
//  Created by Nicholas Ho on 12/11/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddFoodView: View {
    @State private var searchText = ""
    @State private var Hello = "Hello"
    @State private var showVoiceRec = false
    @State private var showCamPage = false
    @State var message = ""
    
    
    struct Food: Identifiable {
        var id: String = UUID().uuidString
        var Calories: Int
        var Carbs: Int
        var name: String
    }


    let testFood = [
        Food(Calories: 95, Carbs: 25, name: "Apple"),
        Food(Calories: 60, Carbs: 15, name: "Orange"),
        Food(Calories: 77, Carbs: 1, name: "Egg"),
        Food(Calories: 165, Carbs: 0, name: "Chicken Breast (165 g)"),
        Food(Calories: 160, Carbs: 6, name: "Avocado")
        ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    Button(action: {showVoiceRec = true}, label: {Image(systemName: "mic.fill")})
                    NavigationLink("", destination: VoiceRec(message: $message), isActive: $showVoiceRec)
                    
                    // play with the frame and padding here
                    TextField("Search Food ...", text: $message)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Button(action: {showCamPage = true}, label: {
                        Image(systemName: "camera")
                    }).disabled(true)
                    NavigationLink("", destination: Camera(), isActive: $showCamPage)
                    
                    Button(action: {Hello = "hellossssss!"}, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    Spacer()
                }
                Spacer();
            
                List(testFood.filter({message.isEmpty ? true : $0.name.contains(message)})) { todo in
                    HStack {
                        Text(todo.name)
                            .font(.title3)
                        Spacer()
                        VStack {
                            Text("Carbs: \(todo.Carbs)")
                                .font(.caption)
                            Text("Calories: \(todo.Calories)")
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
}
    

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
