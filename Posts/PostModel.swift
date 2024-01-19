//
//  PostModel.swift
//  Posts
//
//  Created by Nickelfox on 16/01/24.
//

import Foundation

struct PostModel:Identifiable,Codable{
    var id:Int?
    var userId:Int?
    var title:String
    var body:String
}
