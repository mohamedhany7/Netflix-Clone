//
//  Video.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 19/01/2023.
//

import Foundation

struct YoutubeResponse: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: Video
}

struct Video: Codable {
    let kind: String
    let videoId: String
}
