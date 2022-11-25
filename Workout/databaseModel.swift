import Foundation
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseAuth

class databaseModel : ObservableObject{
    @Published var locations = [LocationObject]()
    private let ref = Database.database().reference()
    private let dbPath = "User/\(Auth.auth().currentUser!.uid)"
    
    init(){
        initListener()
    }
    
    func initListener(){ // why realtime db is so special, can read the data at the same time, no need to update so frequently, no if else if else,  update then update, delete then delte
        ref.child("\(dbPath)/SavedLocation").observe(.value){ snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else{
                return
            }
            self.locations = children.compactMap{ snapshot in
                return try? snapshot.data(as: LocationObject.self)
            }
        }
    }
    
    func addLocation(title: String, long:Double, lat:Double){
        guard let autoId = ref.child(dbPath).childByAutoId().key else {
            return
        }
        
        let location = LocationObject(id:autoId,title:title,long:long,lat:lat)
        do{
            try ref.child("\(dbPath)/SavedLocation/\(autoId)").setValue(from: location)
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func removeLocation(id:String){
        ref.child("\(dbPath)/SavedLocation/\(id)").setValue(nil)
    }
    
}
