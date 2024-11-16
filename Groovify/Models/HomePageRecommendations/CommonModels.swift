//
//  CommonModels.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-16.
//

import Foundation

protocol CarouselItem: Identifiable {
    var name: String { get }
    var images: [SpotifyImage] { get }
}


struct SpotifyImage: Decodable {
    let url: String
    let height: Int?
    let width: Int?
}
