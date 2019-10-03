//
//  WebViewBridge.swift
//  bridge-wkwebview
//
//  Created by Alessandro Nakamuta on 02/10/19.
//  Copyright © 2019 enjoei. All rights reserved.
//

import UIKit
import WebKit

class WebViewBridge: NSObject {
    private static var bridgables: [Bridgable.Type] = []

    private var bridge: Bridgable? {
        didSet {
            if let bridge = oldValue {
                for methodNames in type(of: bridge).methodNames {
                    webView.configuration.userContentController.removeScriptMessageHandler(forName: methodNames)
                }
            }

            if let bridge = bridge {
                for methodNames in type(of: bridge).methodNames {
                    webView.configuration.userContentController.add(self, name: methodNames)
                }
            }
        }
    }
    private let webView: WKWebView
    private let callback: AnyObject

    init(webView: WKWebView, callback: AnyObject) {
        self.webView = webView
        self.callback = callback
    }

    class func register(_ bridgeable: Bridgable.Type) {
        bridgables.append(bridgeable)
    }

    func addBridgedCallbacks(for url: URL) {
        let bridge = WebViewBridge.bridgables.first { (bridgable) -> Bool in
            return bridgable.canBridge(url: url)
        }

        self.bridge = bridge?.init(callback: callback)
    }
}

extension WebViewBridge: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        bridge?.process(message: message)
    }
}

protocol Bridgable {
    init(callback: AnyObject?)

    static var methodNames: [String] { get }

    static func canBridge(url: URL) -> Bool
    func process(message: WKScriptMessage)
}
