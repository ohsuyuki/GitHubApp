//
//  WebViewController.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    private var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url))
    }

    func setUp(url: URL) {
        self.url = url
    }
}
