//
//  AddressModel.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/9.
//

import Foundation

class AddressModel: NSObject, NSCoding {
    var firstName: String?
    var lastName: String?
    var phoneNum: String?
    var state: String?
    var suburb: String?
    var postCode: String?
    var line1: String?
    var line2: String?
    
    init(firstName: String, lastName: String, phoneNum: String, state: String, suburb: String, postCode: String, line1: String, line2: String){
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNum = phoneNum
        self.state = state
        self.suburb = suburb
        self.postCode = postCode
        self.line1 = line1
        self.line2 = line2
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(phoneNum, forKey: "phoneNum")
        coder.encode(state, forKey: "state")
        coder.encode(suburb, forKey: "suburb")
        coder.encode(postCode, forKey: "postCode")
        coder.encode(line1, forKey: "line1")
        coder.encode(line2, forKey: "line2")
    }

    required init?(coder: NSCoder) {
        self.firstName = coder.decodeObject(forKey: "firstName") as? String
        self.lastName = coder.decodeObject(forKey: "lastName") as? String
        self.phoneNum = coder.decodeObject(forKey: "phoneNum") as? String
        self.state = coder.decodeObject(forKey: "state") as? String
        self.suburb = coder.decodeObject(forKey: "suburb") as? String
        self.postCode = coder.decodeObject(forKey: "postCode") as? String
        self.line1 = coder.decodeObject(forKey: "line1") as? String
        self.line2 = coder.decodeObject(forKey: "line2") as? String
    }
}
