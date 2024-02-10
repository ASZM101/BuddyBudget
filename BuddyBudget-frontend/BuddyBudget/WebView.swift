import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // The URL to load in the WebView
    let url: URL?
    
    // Create and return a WKWebView
    func makeUIView(context: Context) -> WKWebView {
        // Set up WKWebViewPreferences to enable JavaScript content
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        // Configure WKWebView with the created preferences
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        // Create and return a WKWebView with the specified configuration
        return WKWebView(
            frame: .zero,
            configuration: config)
    }
    
    // Update the WKWebView with a new URL, if provided
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myURL = url else {
            return
        }
        
        // Load the URLRequest into the WKWebView
        let request = URLRequest(url: myURL)
        uiView.load(request)
    }
}
