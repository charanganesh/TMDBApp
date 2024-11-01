//
//  YouTubePlayerWebView.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import SwiftUI
import UIKit
import WebKit

struct YouTubePlayerWebView: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.allowsInlineMediaPlayback = true
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: "https://www.youtube.com/embed/\(videoId)?playsinline=1") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
