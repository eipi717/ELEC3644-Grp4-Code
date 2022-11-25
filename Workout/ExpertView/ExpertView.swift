//
//  ExpertView.swift
//  Workout
//
//  Created by Nicholas Ho on 12/11/2022.
//

import SwiftUI

struct ExpertView: View {
    var body: some View {
        Form {
            Section(header: Text("Expert")) {
                VStack {
                    Text("Combine healthy eating with exercise")
                        .font(.headline)
                        .bold()
                    Spacer()
                    HStack {
                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            .font(.system(size: 40))
                        Text("Studies show that diet alone is not as effective in achieving a healthy body weight as diet combined with exercise. Physical activity has many other health benefits as well.")
                            .font(.subheadline)
                    }
                }
            }
            
            Section(header: Text("Expert")) {
                VStack {
                    Text("Drink More Water!!")
                        .font(.headline)
                        .bold()
                    Spacer()
                    HStack {
                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            .font(.system(size: 40))
                        Text("It is a common recommendation to drink 8 to 10 glasses of water a day to help your body's biological processes, especially carrying nutrients to cells and eliminating wastes.")
                            .font(.subheadline)
                    }
                }
            }
            
            Section(header: Text("Expert")) {
                VStack {
                    Text("Pay attention to your eating patterns")
                        .font(.headline)
                        .bold()
                    Spacer()
                    HStack {
                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            .font(.system(size: 40))
                        Text("How, when, and where do you eat? If you're like many Americans, you may often eat meals while doing something else: driving, talking on the phone, watching television, or reading. In short, you may pay little attention to your food. As a result: \n\nYou may not always fully taste and enjoy your food. \n\nYou may eat more than you need. \n\nYou may sometimes suffer from indigestion or other gastrointestinal symptoms.")
                            .font(.subheadline)
                    }
                }
            }
            
            Section(header: Text("Expert")) {
                VStack {
                    Text("How much should the average adult exercise every day?")
                        .font(.headline)
                        .bold()
                    Spacer()
                    HStack {
                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            .font(.system(size: 40))
                        Text("Physical activity is anything that gets your body moving. Each week adults need 150 minutes of moderate-intensity physical activity and 2 days of muscle strengthening activity.")
                            .font(.subheadline)
                    }
                }
            }
            
        }
    }
}

struct ExpertView_Previews: PreviewProvider {
    static var previews: some View {
        ExpertView()
    }
}
