//
//  MapView.swift
//  Africa
//
//  Created by Fabian Kuschke on 18.08.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region: MKCoordinateRegion = {
        var mapCoordinnates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.43775)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70, longitudeDelta: 70)
        var mapRegion = MKCoordinateRegion(center: mapCoordinnates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    let locations: [NationalParkLocation] = Bundle.main.decocde("locations.json")
    
    var body: some View {
        
        //MARK: Basic Map
        Map(coordinateRegion: $region, annotationItems: locations, annotationContent: { item in
            //A Pin: Old style always staic
            //MapPin(coordinate: item.location, tint: .accentColor)
            
            
            //B Marker: New Style always static
            //MapMarker(coordinate: item.location, tint: .accentColor)
            
            //C Custom Basic Annotation
//            MapAnnotation(coordinate: item.location) {
//                Image("logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 32, height: 32, alignment: .center)
            //}//Annotation
            
            //D: Custom advanced anoontaion
            MapAnnotation(coordinate: item.location) {
                MapAnnotationView(location: item)
            }
        })//ENd of map
        .overlay (
            HStack(alignment: .center, spacing: 12) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                .frame(width: 48, height: 48, alignment: .center)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack{
                        Text("Latitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    Divider()
                    
                    HStack{
                        Text("Longitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }

                }
            }//HStack
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                Color.black
                    .cornerRadius(8)
                    .opacity(0.6)
            )
            .padding()
            , alignment: .top
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
