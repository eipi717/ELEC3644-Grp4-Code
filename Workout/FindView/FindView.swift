//
//  FindView.swift
//  Workout
//
//
import MapKit
import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct MapView:UIViewRepresentable{
    @Binding var selectedAnnotation: MKPointAnnotation?
    typealias UIViewType = MKMapView
    var annotations:[MKPointAnnotation]
    var region:MKCoordinateRegion
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        print("called update")
        mapView.removeAnnotations(mapView.annotations)
        let HKU = MKPointAnnotation() // set the coordinates and title
        HKU.title = "HKU"
        HKU.coordinate = CLLocationCoordinate2D(latitude: 22.28355, longitude: 114.136892)
        mapView.addAnnotation(HKU)
        for item in annotations{
            mapView.addAnnotation(item)
        }
        
        for (i,a) in mapView.annotations.enumerated(){
            print("[\(i)] \((a.title!)!)  location:\(a.coordinate)")
        }
        
//        if(selectedAnnotation == nil && annotations.count>1){
//            let rand = Int.random(in:0..<annotations.count)
//            selectedAnnotation = annotations[rand]
//        }
    }
    
    func makeCoordinator() -> MapViewDelegate {
        return MapViewDelegate(map:self)
    }
    
    class MapViewDelegate : NSObject, MKMapViewDelegate{
        var map:MapView
        
        init(map:MapView){
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Pin"
            var view:MKMarkerAnnotationView
            //map.selectedAnnotation = annotation as? MKPointAnnotation
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier:identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            }else{
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            return view
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            map.selectedAnnotation = view.annotation as? MKPointAnnotation
            //print(map.selectedAnnotation?.title)
        }
    }
}

struct DirectionView : UIViewRepresentable{
    
    var selectedAnnotation: MKAnnotation?
    var request = MKDirections.Request()
    var mapViewDelegate : MapViewDelegate = MapViewDelegate()
    
    @State var overlay:MKOverlay?   // definethe overlay to the MKmap view
   /////////////////////////
    func makeUIView(context: Context) -> MKMapView {
        //create and unutakize a mkmapview and return to swift ui for display
        let mapView = MKMapView()
        mapView.delegate = mapViewDelegate
        let srcLoc = CLLocation(latitude:  22.28355, longitude: 114.136892)
        let destLoc = CLLocation(latitude: (selectedAnnotation?.coordinate.latitude)!,
                                 longitude: (selectedAnnotation?.coordinate.longitude)!)
        let srcPlacemark = MKPlacemark (coordinate: srcLoc.coordinate)
        let destPlacemark = MKPlacemark(coordinate: destLoc.coordinate)
        request.source = MKMapItem(placemark:  srcPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark) //create the direction requests
        request.requestsAlternateRoutes = false
        request.transportType = .any
        let directions = MKDirections(request: request) // create direction object
        directions.calculate(){(response,error) in // calculagte the routs
            if let res = response, res.routes.count > 0 {
                overlay = res.routes[0].polyline
                print("Direction Response:")
                print(res.routes.count)
                mapView.addOverlay(overlay!)
                mapView.setVisibleMapRect(overlay!.boundingMapRect,
                                          edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                                          animated: true) // zoom in to the region
            }else if error != nil {
                print("Error in search : \(error!.localizedDescription)")
            }else{
                print("No match found")
            }
            
            if request.source != nil{
                let annotation = MKPointAnnotation()
                annotation.coordinate = request.source!.placemark.coordinate
                annotation.title = "HKU"
                mapView.addAnnotation(annotation)
            }
            
            if request.destination != nil{
                let annotation = MKPointAnnotation()
                annotation.coordinate =
                    request.destination!.placemark.coordinate
                annotation.title = (selectedAnnotation!.title)!
                mapView.addAnnotation(annotation)
            }
            
        }
        return mapView
    }
    /////////////////////////
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    /// Plot the route
    class MapViewDelegate:NSObject, MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            var renderer:MKOverlayPathRenderer
            renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 5.0
            return renderer
        }
    }
    
}


struct FindView: View {
    @EnvironmentObject private var viewModel:databaseModel
    @State var annotations:[MKPointAnnotation]=Array()
    @State var searchKey:String = ""
    @State var mapItem: MKMapItem?
    @State var selectedAnnotation: MKPointAnnotation?
    @State var showDirection = false
    @State var showAlert = false
    @State var region:MKCoordinateRegion = MKCoordinateRegion(
        center:CLLocationCoordinate2D(latitude: 22.283, longitude: 114.137),
        latitudinalMeters: 300,
        longitudinalMeters: 300
    )
    var body: some View {
        VStack{
            Form{
                VStack{
                    
                    HStack{
                        TextField("Search here...",text:$searchKey)
                            .frame(height:30)
                    }
                    
                    HStack{
                        if selectedAnnotation == nil{
                            Text("")
                                .frame(height:44)
                        }else{
                            Text(selectedAnnotation!.title!)
                                .frame(height:44)
                        }
                        
                    }
                    
                    HStack(spacing:10){
                        Button(action:{
                            if selectedAnnotation != nil{
                                showDirection=true
                            }
                        }
                        ){
                            HStack{
                                Text("Direction");
                            }
                        }.buttonStyle(MyActionButtonStyle())
                            .disabled(selectedAnnotation==nil)
                        
                        Button(action:{savelocation()}){
                            HStack{
                                Text("Save");
                            }
                        }.buttonStyle(MyActionButtonStyle())
                            .alert(isPresented:$showAlert){
                                Alert(
                                    title: Text("Location Saved"),
                                    dismissButton: .default(Text("Got it!"))
                                )
                            }.disabled(
                                selectedAnnotation==nil
                            )
                    }
                    
                    HStack(){
                        Button(action:{
                            search(key:searchKey)
                        }){
                            HStack{
                                Text("Search");
                            }
                        }.buttonStyle(MyActionButtonStyle())
                            .disabled(searchKey=="")
                    }
                    
                    Button(action:{reset()}){
                        HStack{
                            Text("Clear");
                        }
                    }.buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.blue)
                        .frame(height:44)
                }
            }.frame(height:350)
            
            if (showDirection){
                DirectionView(selectedAnnotation:selectedAnnotation)
            }else{
                MapView(selectedAnnotation:$selectedAnnotation,annotations:annotations,region:region)
            }
        }.onAppear(perform:{
            search(key:"gym")
        })
    }
    
    
    func reset(){   //clear button
        selectedAnnotation = nil
        showDirection = false
        searchKey=""
    }
    
    func savelocation(){
        if(selectedAnnotation != nil){
            let long = selectedAnnotation!.coordinate.longitude
            let lat = selectedAnnotation!.coordinate.latitude
            let title = selectedAnnotation!.title!
            viewModel.addLocation(title:title, long:long, lat:lat)
            showAlert = true
        }
    }
    
    func search(key:String){
        showDirection = false
        let request = MKLocalSearch.Request()  // get the request object
        request.naturalLanguageQuery = key // set search criteria
        request.region = region //same as above
        let search = MKLocalSearch(request:request) //create search object
        search.start(completionHandler: procSearchResult)//closure that handles the result
    }
    
    func procSearchResult(response:MKLocalSearch.Response?,error:Error?){
        if error != nil{
            print("Error in search:\(error!.localizedDescription)")
        }else if response!.mapItems.count > 0{
            annotations.removeAll()
            for item in response!.mapItems{
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotations.append(annotation)
            }
        }else{
            print("No match found")
        }
    }
}

struct MyActionButtonStyle : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(height:44)
            .frame(maxWidth:.infinity)
            .background(Color.blue)
            .cornerRadius(8)
    }
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
