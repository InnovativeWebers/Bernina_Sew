//
//  Event.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import Foundation

struct EventList: Decodable {
    var Events:[Event]
}
//
//struct Event: Decodable{
//    var Name: String
//    var Level: String
//    var Date: String
//    var Description: String
//}

class Event: NSObject, NSCoding, Decodable{

    var Name: String
    var Level: String
    var Date: String
    var Description: String
    
    init(Name: String, Level: String, Date: String, Description: String){
        self.Name = Name
        self.Level = Level
        self.Date = Date
        self.Description = Description
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(Name, forKey: "EventName")
        coder.encode(Level, forKey: "EventLevel")
        coder.encode(Date, forKey: "EventDate")
        coder.encode(Description, forKey: "EventDescription")
    }
    
    required init?(coder: NSCoder) {
        self.Name = (coder.decodeObject(forKey: "EventName") as? String)!
        self.Level = (coder.decodeObject(forKey: "EventLevel") as? String)!
        self.Date = (coder.decodeObject(forKey: "EventDate") as? String)!
        self.Description = (coder.decodeObject(forKey: "EventDescription") as? String)!
        
    }
    
}
