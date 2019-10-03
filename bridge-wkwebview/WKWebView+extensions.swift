//
//  WKWebView+extensions.swift
//  bridge-wkwebview
//
//  Created by Alessandro Nakamuta on 02/10/19.
//  Copyright © 2019 enjoei. All rights reserved.
//

import WebKit

extension WKWebView {
    func evaluateJavaScript(name: String, params: [Any], completionHandler: ((Any?, Error?) -> Void)? = nil) {
        let normalizedName: String
        if let splitedName = name.split(separator: "(").first {
            normalizedName = String(splitedName)
        } else {
            normalizedName = name
        }

        let normalizedParams = params.map { (param) -> String in
            if param is Int || param is Float || param is Double {
                return "\(param)"
            } else if let param = param as? Bool {
                return param ? "true" : "false"
            }

            return "'\(param)'"
            }.joined(separator: ", ")

        evaluateJavaScript("\(normalizedName)(\(normalizedParams))", completionHandler: completionHandler)
    }
}
