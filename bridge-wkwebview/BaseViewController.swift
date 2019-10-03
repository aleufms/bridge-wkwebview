//
//  BaseViewController.swift
//  bridge-wkwebview
//
//  Created by Alessandro Nakamuta on 02/10/19.
//  Copyright © 2019 enjoei. All rights reserved.
//

import UIKit
import WebKit

class BaseViewController: UIViewController {
    var webViewBridge: WebViewBridge?

    lazy var webview: WKWebView = {
        let webview = WKWebView()
        webview.navigationDelegate = self
        return webview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        webViewBridge = WebViewBridge(webView: webview, callback: self)

        view.addSubview(webview)
        webview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: view.topAnchor),
            webview.leftAnchor.constraint(equalTo: view.leftAnchor),
            webview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webview.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
}

extension BaseViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        webViewBridge?.addBridgedCallbacks(for: url)
    }
}
