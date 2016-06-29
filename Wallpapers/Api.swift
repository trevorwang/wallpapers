//
//  Api.swift
//  Wallpapers
//
//  Created by Ming Wang on 6/28/16.
//  Copyright © 2016 Mingsin. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

let ApiProvider = RxMoyaProvider<Api>()

public enum Api {
    case WallPapers
}

extension Api: TargetType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.desktoppr.co/1/")!
    }
    
    public var path:String
    {
        switch self {
        case .WallPapers:
            return "/wallpapers"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String : AnyObject]? {
        return nil
    }
    
    public var sampleData: NSData {
        return NSData()
    }
}

extension Api {
    public static func allWallpapers(on:(Event<WprResult> -> Void)) {
        _ = ApiProvider.request(.WallPapers).mapObject(WprResult).subscribe {
            e in on(e)
        }
    }
}

public struct WprResult: Mappable {
    var response:[Wallpaper] = []
    var count:Int = 0
    var pagination:AnyObject?
    init(){}
    public init?(_ map: Map) {
    }
    mutating public func mapping(map: Map) {
        response <- map ["response"]
        count <- map ["count"]
        pagination <- map ["pagination"]
    }
}

public struct Wallpaper:Mappable {
    var id:Int = 0
    var bytes:Int = 0
    var createdAt:String = ""
    var height:Int = 0
    var width:Int = 0
    var reviewState:String = "safe"
    var uploader:String = ""
    var userCount:Int = 0
    var linkesCount:Int = 0
    var palette:[String] = []
    var url:String = ""
    var image:WprImage = WprImage()
    init(){}
    public init?(_ map: Map) {
    }
    public mutating func mapping(map: Map) {
        id <- map["id"]
        bytes <- map["bytes"]
        height <- map["height"]
        width <- map["width"]
        createdAt <- map["created_at"]
        reviewState <- map["review_state"]
        uploader <- map["uploader"]
        image <- map["image"]
        palette <- map["palette"]
        url <- map["url"]
    }
}

public struct WprImage:Mappable {
    var url:String = ""
    var thumbUrl:String = ""
    var thumbWidth:Int = 0
    var thumbHeight:Int = 0
    
    var previewUrl:String = ""
    var previewWidth:Int = 0
    var previewheight:Int = 0
    init(){}
    public init?(_ map: Map) {
    }
    public mutating func mapping(map: Map) {
        url <- map["url"]
        thumbUrl <- map["thumb.url"]
        thumbWidth <- map["thumb.width"]
        thumbHeight <- map["thumb.height"]
        previewUrl <- map["preview.url"]
        previewWidth <- map["preview.width"]
        previewheight <- map["preview.height"]
    }
}
