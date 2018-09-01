//
//  MapViewController.swift
//  QueroConhecer
//
//  Created by Douglas Frari on 02/06/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viInfo: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    
    var places: [Place]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isHidden = true
        viInfo.isHidden = true
        // configura o título
        if places.count == 1 {
            title = places[0].name
        } else {
            title = "Meus lugares"
        }
       
        
        for place in places {
            addPlace(place)
            
        }
        
        
        showPlaces()
    }
    
    func showPlaces() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    
    func addPlace(_ place:Place)
    {
//        print(place.name)
    
        print("Place -> \(place.name)")
        places.append(place)
        
        // usando Annotations
        let annotation = PlaceAnnotation(coordinate: place.coordinate, type: .place)
        annotation.address = place.address
        annotation.coordinate = place.coordinate // variavel computada
        annotation.title = place.name
        mapView.addAnnotation(annotation)
        
        mapView.addAnnotation(annotation)
    }
    
    
    
   
    
    
    @IBAction func showRoute(_ sender: UIButton) {
    }
    
    
    @IBAction func showSearchBar(_ sender: UIBarButtonItem) {
    }


}
extension MapViewController: MKMapViewDelegate {
    
    // usado para recuperar uma annotationView para permitir modifica-la
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is PlaceAnnotation) {
            // mantem o default caso nao seja o tipo esperado.
            return nil
        }
        
        let placeAnnotation = annotation as! PlaceAnnotation
        let type = placeAnnotation.type
        let identifier = "\(type)"
        // tentando reusar uma view do pino padrao (MKMarkerAnnotationView)
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            // criando pela primeira vez uma annotation view
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.annotation = annotation
        annotationView?.canShowCallout = true // informacoes extras na forma de um balao
        // usando Point of Interess
        annotationView?.markerTintColor = type == .place ? UIColor(named: "main") : UIColor(named: "poi")
        annotationView?.glyphImage = type == .place ? #imageLiteral(resourceName: "placeGlyph") : #imageLiteral(resourceName: "poiGlyph")
        annotationView?.displayPriority = type == .place ? .required : .defaultHigh
        
        return annotationView
    }
    
}
