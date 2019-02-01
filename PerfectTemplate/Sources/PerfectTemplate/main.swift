//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
import PerfectLib
import Foundation

func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

func handler(request: HTTPRequest, response: HTTPResponse) {
    let userDict:[String:String] = ["username":"zhangsan","gender":"male"]
    let result:[String:Any] = ["code":"200", "data":userDict, "msg":"success"]
    response.setBody(string: getJSONStringFromDictionary(dictionary: result as NSDictionary))
    response.completed()
}

let confData = [
    "servers":[
        [
            "name":"localhost",
            "port":8080,
            "routes": [
                ["method":"get", "uri":"/login", "handler": handler]
            ]
        ]
    ]
]

do {
    try HTTPServer.launch(configurationData: confData)
} catch {
    fatalError("\(error)")
}

