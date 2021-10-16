//
//  DesignModel.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/15.
//

import UIKit

class DesignModel: NSObject, NSCoding {
    
    var PatternImageURL: String?
    var ProductImageURL: String?
    
    init(pattern: String, product: String){
        self.PatternImageURL = pattern
        self.ProductImageURL = product
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(PatternImageURL, forKey: "PatternURL")
        coder.encode(ProductImageURL, forKey: "ProductURL")
    }
    
    required init?(coder: NSCoder) {
        self.PatternImageURL = coder.decodeObject(forKey: "PatternURL") as? String
        self.ProductImageURL = coder.decodeObject(forKey: "ProductURL") as? String
    }
    
    
}
