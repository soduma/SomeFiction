//
//  NaverResponse.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/19.
//

import Foundation
import MapKit

struct NaverResponse: Codable {
    let items: [Movie]
}

struct Movie: Codable {
    private let title: String
    let link: String
    let image: String
    private let director: String
    private let actor: String
    let userRating: String
    
    var newTitle: String {
        return title.replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
    
    var newDirector: String {
        if director.isEmpty == false {
            var text = director.replacingOccurrences(of: "|", with: ", ")
            text.removeLast(2)
            return text
        } else {
            return director
        }
    }
    
    var newActor: String {
        if actor.isEmpty == false {
            var text = actor.replacingOccurrences(of: "|", with: ", ")
            text.removeLast(2)
            return text
        } else {
            return actor
        }
    }
}
