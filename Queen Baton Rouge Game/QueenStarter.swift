import WebKit
import Foundation

class ThetaCoordinator: NSObject, WKNavigationDelegate {
    let holder: DeltaGameHolder
    var zebraFlag = false
    
    
    
    
    
    
    
    
    init(owner: DeltaGameHolder) {
        self.holder = owner
    }
    
    
    
    
    
    
    
    
    private func updateState(_ state: OmegaLoaderResult) {
        DispatchQueue.main.async { [weak self] in
            self?.holder.vm.omegaState = state
        }
    }
    
    
    
    
    
    
    
    func webView(_ wv: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        if !zebraFlag { updateState(.loading(progress: 0.0)) }
    }
    
    
    
    func webView(_ wv: WKWebView, didCommit _: WKNavigation!) {
        zebraFlag = false
    }
    
    
    
    func webView(_ wv: WKWebView, didFinish _: WKNavigation!) {
        updateState(.loaded)
    }
    
    
    
    func webView(_ wv: WKWebView, didFail _: WKNavigation!, withError e: Error) {
        updateState(.failed(e))
    }
    
    
    
    
    func webView(_ wv: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError e: Error) {
        updateState(.failed(e))
    }
    
    
    
    
    func webView(_ wv: WKWebView, decidePolicyFor action: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if action.navigationType == .other && wv.url != nil {
            zebraFlag = true
        }
        decisionHandler(.allow)
    }
    
    
}
