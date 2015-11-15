//
//  ItemNewSite.swift
//  TourWishlist
//
//  Created by USUARIO on 11/14/15.
//  Copyright © 2015 ciroSoft. All rights reserved.
//
import UIKit
import CoreData
class ItemNewSite: UIViewController {
    
    @IBOutlet weak var ImageSite: UIImageView!
    @IBOutlet weak var LongSite: UITextField!
    @IBOutlet weak var LatSite: UITextField!
    @IBOutlet weak var DesripcionSite: UITextView!
    @IBOutlet weak var NombreSite: UITextField!
    var currentItem: NSManagedObject!
    var tolatitud:String!
    var tolongitud:String!
    
    @IBAction func BackHome(sender: AnyObject) {
        print("back")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func SaveSite(sender: AnyObject) {
        print("Save")
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext
        let en = NSEntityDescription.entityForName("MiSites", inManagedObjectContext: contxt)
        if (currentItem != nil){
            currentItem.setValue(NombreSite.text, forKey: "nombre");
            currentItem.setValue(DesripcionSite.text, forKey: "descripcion");
            currentItem.setValue(LatSite.text, forKey: "latitud");
            currentItem.setValue(LongSite.text, forKey: "longitud");
            currentItem.setValue(LongSite.text, forKey: "imagen");
        } else {
            let newItem = MiSites(entity:en!, insertIntoManagedObjectContext:contxt)
            newItem.nombre = NombreSite.text!
            newItem.descripcion = DesripcionSite.text!
            newItem.latitud = LatSite.text!
            newItem.longitud = LongSite.text!
            newItem.imagen = LongSite.text!
            print(newItem)
            
        }
        
        do {
            try contxt.save()
        } catch _ {
        }

        self.navigationController?.popToRootViewControllerAnimated(true)
        //ViewController().PointsRemove()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("show")
        if(currentItem != nil){
            print (currentItem)
            NombreSite.text = currentItem.valueForKey("nombre") as? String
            DesripcionSite.text = currentItem.valueForKey("descripcion") as? String
            LatSite.text = currentItem.valueForKey("latitud") as? String
            LongSite.text = currentItem.valueForKey("longitud") as? String
        } else {
            LongSite.text = tolongitud
            LatSite.text = tolatitud
        }
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
}

