//
//  CalcViewController.swift
//  bridge-wkwebview
//
//  Created by Alessandro Nakamuta on 01/10/19.
//  Copyright © 2019 enjoei. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class CalcViewController: BaseViewController {
    var value1: String = ""
    var value2: String = ""
    var callback: ((_ value1: String, _ value2: String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        //pass value1 and value 2 in query params
        //        if let url = URL(string: "https://enjoei.com.br/calc?value1=\"\(value1)\"&value2=\"\(value2)\"") {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webview.load(URLRequest(url: url))
        }
    }

    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webview, didFinish: navigation)

        fillValues(value1: value1, value2: value2)
    }

    func fillValues(value1: String, value2: String) {
        webview.evaluateJavaScript(name: #function,
                                   params: [value1, value2],
                                   completionHandler: nil)
    }
}

extension CalcViewController: CalcBridgeCallback {
    func exempleMethod(value1: String, value2: String) {
        callback?(value1, value2)
        dismiss(animated: true)
    }
}

@objc protocol CalcWrapperProtocol: JSExport {
    var fillValues: (@convention(block)() -> Void)? { get }
}
