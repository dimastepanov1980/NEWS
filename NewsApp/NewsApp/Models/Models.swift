//
//  Models.swift
//  NewsApp
//
//  Created by Dmitriy Stepanov on 18.08.2022.
//

import Foundation

struct APIResponce : Codable {
    let articles : [Article]
}

struct Article : Codable {
    let source : Source
    let title : String?
    let description : String?
    let url : String?
    let urlToImage: String?
    let publishedAt: String?
    
}

struct Source : Codable {
    
    let name : String?
}
