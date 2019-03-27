//
//  PhotosResponse.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 25.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct PhotosResponse: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let ownername: String
    
    var imageURL: String {
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
