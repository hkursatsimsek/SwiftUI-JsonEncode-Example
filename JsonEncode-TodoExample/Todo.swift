//
//  Todo.swift
//  JsonEncode-TodoExample
//
//  Created by Kürşat Şimşek on 1.11.2021.
//

import Foundation

struct Todo : Codable, Identifiable {
    public var id : String
    public var title: String
    public var completed: Bool
}


struct TodoResponse: Codable, Identifiable {
    public var id:String?
    public var todom: [Todo]?
}
