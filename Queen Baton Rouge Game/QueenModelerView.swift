import WebKit
import Foundation
import SwiftUI

class GammaViewModel: ObservableObject {
    @Published var omegaState: OmegaLoaderResult = .idle
    let linkForLoader: URL
    private var zebraScene: WKWebView?
    private var obsrvKey: NSKeyValueObservation?
    private var currentProgress: Double = 0.0
    
    init(url: URL) {
        self.linkForLoader = url
    }
    
    func setWebView(_ webView: WKWebView) {
        self.zebraScene = webView
        observeLoading(webView)
        startLoadZebra()
    }
    
    func startLoadZebra() {
        guard let webView = zebraScene else { return }
        let request = URLRequest(url: linkForLoader, timeoutInterval: 15.0)
        DispatchQueue.main.async { [weak self] in
            self?.omegaState = .loading(progress: 0.0)
            self?.currentProgress = 0.0
        }
        webView.load(request)
    }
    
    private func observeLoading(_ webView: WKWebView) {
        obsrvKey = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            let progress = webView.estimatedProgress
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if progress > self.currentProgress {
                    self.currentProgress = progress
                    self.omegaState = .loading(progress: self.currentProgress)
                }
                if progress >= 1.0 {
                    self.omegaState = .loaded
                }
            }
        }
    }
    
    func updateNetworkStatus(_ isConnected: Bool) {
        if isConnected && omegaState == .noInternet {
            startLoadZebra()
        } else if !isConnected {
            DispatchQueue.main.async { [weak self] in
                self?.omegaState = .noInternet
            }
        }
    }
}
