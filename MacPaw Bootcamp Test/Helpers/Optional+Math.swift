//
//  Optional+Math.swift
//  MacPaw Bootcamp Test
//
//  Created by Ivan Skoryk on 26.08.2023.
//

import Foundation

func + (left: Int?, right: Int?) -> Int? {
    return left != nil ? right != nil ? left! + right! : left : right
}

func - (left: Int?, right: Int?) -> Int? {
    return left != nil ? right != nil ? left! - right! : left : right
}

func += (left: inout Int?, right: Int?) {
    left = left + right
}

func -= (left: inout Int?, right: Int?) {
    left = left - right
}
