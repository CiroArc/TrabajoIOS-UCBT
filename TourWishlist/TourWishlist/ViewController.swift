//
//  ViewController.swift
//  TourWishlist
//
//  Created by USUARIO on 11/14/15.
//  Copyright © 2015 ciroSoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    let locationManager = CLLocationManager()
    var appDelegate: AppDelegate!
    var Latitude: Double!
    var Longitude: Double!
    var sharedContext: NSManagedObjectContext!
    
       override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "dropPin:")
        longPress.minimumPressDuration = 0.5
        myMap.addGestureRecognizer(longPress)
        self.myMap.showsUserLocation = true
        
        Latitude = -21.523762
        Longitude = -64.728061
        var span = MKCoordinateSpanMake(0.075, 0.075)
        var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude), span: span)
        myMap.setRegion(region, animated: true)
       
        listPoints()
        print("Load Map..")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addsite")
        {   print("Add...")
            
            let desti = segue.destinationViewController as! ItemNewSite
            desti.tolatitud = String(Latitude)
            desti.tolongitud = String(Longitude)
        }
    }

    
    func dropPin(gestureRecognizer: UIGestureRecognizer) {
        
        let tapPoint: CGPoint = gestureRecognizer.locationInView(myMap)
        let touchMapCoordinate: CLLocationCoordinate2D = myMap.convertPoint(tapPoint, toCoordinateFromView: myMap)
        
        if UIGestureRecognizerState.Began == gestureRecognizer.state {
            Latitude = touchMapCoordinate.latitude
            Longitude = touchMapCoordinate.longitude
            
            print("lat \(Latitude)")
            print("long \(Longitude)")
            print("agregar")
            performSegueWithIdentifier("addsite", sender: nil)

            
           /* let newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = touchMapCoordinate
            newAnnotation.title = "Nuevo Agredado"
            newAnnotation.subtitle = "mi lugar favorito"
            myMap.addAnnotation(newAnnotation)*/
            
            //initialize our Pin with our coordinates and the context from AppDelegate
           /* let pin = Pin(annotationLatitude: touchMapCoordinate.latitude, annotationLongitude: touchMapCoordinate.longitude, context: appDelegate.managedObjectContext!)
            //add the pin to the map
            mapView.addAnnotation(pin)
            //save our context. We can do this at any point but it seems like a good idea to do it here.
            appDelegate.saveContext()*/
        }
    }

    func PointsRemove()
    {
        
        myMap.removeAnnotations(myMap.annotations)
        
       /* let visRect = myMap.visibleMapRect
        let inRectAnnotations = myMap.annotationsInMapRect(visRect)
        for anno : MKAnnotation in myMap.annotations {
            myMap.removeAnnotation(anno)
        }*/
        listPoints()
        
        }
    
    func listPoints()
    {
        var myLista:Array<AnyObject> = []
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let freq = NSFetchRequest (entityName: "MiSites")
        
        var data:NSManagedObject!
        var latcoredat: Double!
        var longcoredat: Double!
        var nombcoredat: String!
        var descoredat: String!
        //var coordinate: CLLocationCoordinate2D!
        
        
        myLista = try! context.executeFetchRequest(freq)
        for var i = 0; i < myLista.count; i++
        {
            data = myLista[i] as! NSManagedObject
            latcoredat = Double((data.valueForKey("latitud") as? String)!)
            longcoredat = Double((data.valueForKey("longitud") as? String)!)
            nombcoredat = (data.valueForKey("nombre") as? String)!
            descoredat = (data.valueForKey("descripcion") as? String)!
            
            print(nombcoredat)
           
            var coordinate: CLLocationCoordinate2D {
                return CLLocationCoordinate2D(latitude: latcoredat as Double, longitude: longcoredat as Double)
                }
                
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = coordinate
                newAnnotation.title = nombcoredat
                newAnnotation.subtitle = descoredat
                myMap.addAnnotation(newAnnotation)
            
            
        }
        
       /* for result: AnyObject in myLista {
            
            if let latcoredat: AnyObject = result.valueForKey("latitud") {
                
                print(latcoredat)
                
            }
            
        }*/
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.myMap.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

