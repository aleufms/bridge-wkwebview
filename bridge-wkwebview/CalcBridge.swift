//
//  CalcBridge.swift
//  bridge-wkwebview
//
//  Created by Alessandro Nakamuta on 02/10/19.
//  Copyright © 2019 enjoei. All rights reserved.
//

import UIKit
import WebKit

enum CalcBridgeMethods: String, CaseIterable {
    case exampleMethod
}

class CalcBridge: Bridgable {
    static let methodNames = CalcBridgeMethods.allCases.map({ return $0.rawValue })

    weak var callback: AnyObject?

    required init(callback: AnyObject?) {
        self.callback = callback
    }

    class func canBridge(url: URL) -> Bool {
        return true //TODO: verificar se é url de calc
    }

    func process(message: WKScriptMessage) {
        guard let method = CalcBridgeMethods(rawValue: message.name),
            let body = message.body as? [String: AnyObject] else { return }

        switch method {
        case .exampleMethod:
            guard let value1 = body["value1"] as? String,
                let value2 = body["value2"] as? String else { return }

            if let callback = callback as? CalcBridgeCallback {
                callback.exempleMethod(value1: value1, value2: value2)
            }
        }
    }
}

protocol CalcBridgeCallback {
    func exempleMethod(value1: String, value2: String)
}
