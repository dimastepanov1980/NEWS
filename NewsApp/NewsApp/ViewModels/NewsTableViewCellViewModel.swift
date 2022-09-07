//
//  NewsTableViewModel.swift
//  NewsApp
//
//  Created by Dmitriy Stepanov on 19.08.2022.
//

import Foundation
import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL : URL?
    var imageData: Data? = nil
    init ( title: String,
           subtitle: String,
           imageURL : URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

}
