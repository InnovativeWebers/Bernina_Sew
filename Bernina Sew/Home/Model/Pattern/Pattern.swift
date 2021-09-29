//
//  Pattern.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/13.
//

import UIKit

struct PatternList: Decodable {
    var Patterns:[Pattern]
}

//struct Pattern: Decodable{
//    var ID: Int
//    var Name: String
//    var Image: String
//    var Description: String
//}

class Pattern: NSObject, NSCoding, Codable{

    var ID: Int
    var Name: String
    var Image: String
    var Description: String
    
    init(ID: Int, Name: String, Image: String, Description: String){
        self.ID = ID
        self.Name = Name
        self.Image = Image
        self.Description = Description
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(ID, forKey: "ProductID")
        coder.encode(Name, forKey: "ProductName")
        coder.encode(Image, forKey: "ProductImage")
        coder.encode(Description, forKey: "ProductDescription")
    }
    
    required init?(coder: NSCoder) {
        self.ID = (coder.decodeObject(forKey: "ProductID") as? Int)!
        self.Name = (coder.decodeObject(forKey: "ProductName") as? String)!
        self.Image = (coder.decodeObject(forKey: "ProductImage") as? String)!
        self.Description = (coder.decodeObject(forKey: "ProductDescription") as? String)!
    }
    
    
    
}
