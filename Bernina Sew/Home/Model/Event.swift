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

struct Event: Decodable{
    var Name: String
    var Level: String
    var Date: String
    var Description: String
}
