//
//  Product.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit

struct ProductList: Decodable {
    var FeaturedProducts: [Product]
}


class Product: NSObject, NSCoding, Decodable {

    
    var ID: Int?
    var Name: String?
    var Image: String?
    var Price: Int?
    var Description: String?
    
    init(ID: Int, Name: String, Image: String, Price: Int, Description: String){
        self.ID = ID
        self.Name = Name
        self.Image = Image
        self.Price = Price
        self.Description = Description
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(ID, forKey: "ID")
        coder.encode(Name, forKey: "Name")
        coder.encode(Image, forKey: "Image")
        coder.encode(Price, forKey: "Price")
        coder.encode(Description, forKey: "Description")
    }
    
    required init?(coder: NSCoder) {
        self.ID = coder.decodeObject(forKey: "ID") as? Int
        self.Name = coder.decodeObject(forKey: "Name") as? String
        self.Image = coder.decodeObject(forKey: "Image") as? String
        self.Price = coder.decodeObject(forKey: "Price") as? Int
        self.Description = coder.decodeObject(forKey: "Description") as? String
    }
}
