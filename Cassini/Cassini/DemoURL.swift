//
//  URL.swift
//
//  Created by CS193p Instructor.
//  Copyright (c) 2016 Stanford University. All rights reserved.
//

import Foundation

struct DemoURL
{
    static let Stanford = "http://i2.hdslb.com/bfs/archive/5dad81a9ec2fb45d345625e48f7cc1548c0b5274.jpg"

    static let HZW = [
        "Cassini" : "http://bbs.zhuoxiu.com.cn/data/attachment/forum/201305/09/173000rr5y6f9de50rzezr.jpg",
        "Earth" : "http://c.hiphotos.baidu.com/zhidao/pic/item/42a98226cffc1e17b81677644b90f603738de93e.jpg",
        "Saturn" : "http://k.87.re/2015/12/b9b0747c441e772.jpg"
    ]
    
    static func HZWImageNamed(_ imageName: String?) -> URL?
    {
        if let urlString = HZW[imageName ?? ""] {
            return URL(string: urlString)
        } else {
            return nil
        }
    }
}
