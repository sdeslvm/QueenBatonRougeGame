import WebKit
import Foundation
import SwiftUI

struct DeltaGameHolder: UIViewRepresentable {
    @ObservedObject var vm: GammaViewModel
    
    
    
    
    
    func makeCoordinator() -> ThetaCoordinator {
        ThetaCoordinator(owner: self)
    }
    
    
    
    
    
    
    
    func makeUIView(context: Context) -> WKWebView {
        let phi = WKWebViewConfiguration()
        phi.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let omegaView = WKWebView(frame: .zero, configuration: phi)
        omegaView.backgroundColor = BetaUIColor(omicron: "#141f2b")
        omegaView.isOpaque = false
        let chiTypes = Set([WKWebsiteDataTypeDiskCache,
                            WKWebsiteDataTypeMemoryCache,
                            WKWebsiteDataTypeCookies,
                            WKWebsiteDataTypeLocalStorage])
        WKWebsiteDataStore.default().removeData(ofTypes: chiTypes,
                                                modifiedSince: Date.distantPast) {}
        debugPrint("Renderer: \(vm.linkForLoader)")
        omegaView.navigationDelegate = context.coordinator
        vm.setWebView(omegaView)
        return omegaView
    }
    
    
    
    
    
    func updateUIView(_ view: WKWebView, context: Context) {
        let chiTypes = Set([WKWebsiteDataTypeDiskCache,
                            WKWebsiteDataTypeMemoryCache,
                            WKWebsiteDataTypeCookies,
                            WKWebsiteDataTypeLocalStorage])
        WKWebsiteDataStore.default().removeData(ofTypes: chiTypes,
                                                modifiedSince: Date.distantPast) {}
    }
}

