//
//  Meal.swift
//  FoodTracker
//
//  Created by Valentin Šarić on 08/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import os.log

class Meal : NSObject, NSCoding {
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
   
        self.init(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }

    init?(name: String, photo: UIImage?, rating: Int){
        guard !name.isEmpty else{
            return nil
        }
        
        guard (rating >= 0)&&(rating<6) else{
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
   
}
