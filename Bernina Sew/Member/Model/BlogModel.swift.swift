//
//  BlogModel.swift.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/12.
//

import Foundation

class BlogModel: NSObject, NSCoding {

    var BlogTitle: String?
    var BlogContent: String?
    var Time: String?
    
    init(BlogTitle: String, BlogContent: String, Time: String){
        self.BlogTitle = BlogTitle
        self.BlogContent = BlogContent
        self.Time = Time
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(BlogTitle, forKey: "BlogTitle")
        coder.encode(BlogContent, forKey: "BlogContent")
        coder.encode(Time, forKey: "Time")
    }
    
    required init?(coder decoder: NSCoder) {
        self.BlogTitle = decoder.decodeObject(forKey: "BlogTitle") as? String
        self.BlogContent = decoder.decodeObject(forKey: "BlogContent") as? String
        self.Time = decoder.decodeObject(forKey: "Time") as? String
    }
    
}
