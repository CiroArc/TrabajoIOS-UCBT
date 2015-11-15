//
//  MiSites.swift
//  TourWishlist
//
//  Created by USUARIO on 11/14/15.
//  Copyright © 2015 ciroSoft. All rights reserved.
//
import UIKit
import CoreData
import MapKit

@objc (Model)
class MiSites: NSManagedObject {
    @NSManaged var nombre:String
    @NSManaged var descripcion:String
    @NSManaged var latitud:String
    @NSManaged var longitud:String
    @NSManaged var imagen:String
    
}
