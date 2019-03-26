//
//  FlickrAPI.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 25.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Moya

let request = MoyaProvider<FlickrAPI>()

enum FlickrAPI {
    case getRecentPhotos
}

extension FlickrAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest")!
    }
    
    var path: String {
        return "/"
    }
    
    var method: Method {
        switch self {
        case .getRecentPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        if method == .post {
            return Task.requestParameters(parameters: parameters, encoding: URLEncoding(destination: .queryString))
            //return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        } else {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any] {
        var defaultParameters: [String : Any] = [
            "api_key": ApiConstants.API_KEY,
            "format": "json",
            "nojsoncallback": 1
        ]
        switch self {
        case .getRecentPhotos:
            defaultParameters["method"] = "flickr.photos.getRecent"
            return defaultParameters
        }
    }
    
}
