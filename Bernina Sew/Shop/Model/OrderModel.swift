//
//  OrderModel.swift.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/13.
//

import Foundation

class OrderModel: NSObject, NSCoding {
    
    var orderId: Int?
    var orderTime: String?
    var orderValue: Int?
    
    init(orderId: Int, orderTime: String, orderValue: Int){
        self.orderId = orderId
        self.orderTime = orderTime
        self.orderValue = orderValue
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(orderId, forKey: "OrderID")
        coder.encode(orderTime, forKey: "OrderTime")
        coder.encode(orderValue, forKey: "OrderValue")
    }
    
    required init?(coder: NSCoder) {
        self.orderId = coder.decodeObject(forKey: "OrderID") as? Int
        self.orderTime = coder.decodeObject(forKey: "OrderTime") as? String
        self.orderValue = coder.decodeObject(forKey: "OrderValue") as? Int
    }
    
    
}
