//
//  MyItem.swift
//  TableViewEx
//
//  Created by 김종권 on 2021/07/27.
//

import Foundation

typealias MyItemList = [MyItem]

struct MyItem {
    enum MyType {
        case a
        case b

        case c
        case d
        case e
    }

    let title: String
    let type: MyType
}
