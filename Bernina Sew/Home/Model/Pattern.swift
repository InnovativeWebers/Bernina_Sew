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

struct Pattern: Decodable{
    var ID: Int
    var Name: String
    var Image: String
}
