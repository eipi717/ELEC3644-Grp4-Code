
import SwiftUI
import MapKit

struct SavedLocationView: View {
    @EnvironmentObject private var viewModel : databaseModel
    var body: some View {
        NavigationView(){
            List{
                ForEach(viewModel.locations, id: \.id){ location in
                    Button(action:{
                        let long = location.long    //get the data of location
                        let lat = location.lat
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        let placemark = MKPlacemark(coordinate: coordinate)  //change coordinate to place mark
                        let mapItem:MKMapItem = MKMapItem(placemark: placemark)
                        mapItem.openInMaps(launchOptions:nil) // change placemark to map item
                    }){
                        HStack{
                            Text(location.title)
                        }
                    }.padding()
                }.onDelete(perform: deleteRow(indexSet:))
            }.navigationTitle("Saved Location")
        }
    }
    
    private func deleteRow(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let id = viewModel.locations[index].id
        viewModel.removeLocation(id: id)
    }

}

struct SavedLocation_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationView()
    }
}
