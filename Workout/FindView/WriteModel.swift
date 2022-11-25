//
//  WriteModel.swift
//  Workout
//
//  Created by MacOS on 22/11/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseAuth
import MapKit


class WriteViewModel : ObservableObject{
    private let ref = Database.database().reference()
    
    @Published var listObject: [LocationObject]?
    
    func pushNewSavedLocation(_loaction: MKPointAnnotation)->Bool{
        let long = _loaction.coordinate.longitude
        let lat = _loaction.coordinate.latitude
        let title = _loaction.title!
        self.ref.child("User").child(Auth.auth().currentUser!.uid).child("SavedLocation").child(title).setValue("\(long),\(lat)")
        return true
    }
    
    func getData(){
        ref.observe(.value){ parentSnapshot  in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else{
                return
            }
            self.listObject = children.compactMap({ DataSnapshot in
                return try? DataSnapshot.data(as: LocationObject.self)
            })
        }
        
    }
}
