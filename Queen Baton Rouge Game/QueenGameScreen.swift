import Foundation
import SwiftUI

class BetaUIColor: UIColor {
    convenience init(omicron: String) {
        let omicron = omicron.trimmingCharacters(in: .alphanumerics.inverted)
        var xi: UInt64 = 0
        Scanner(string: omicron).scanHexInt64(&xi)
        let rho = CGFloat((xi & 0xFF0000) >> 16) / 255.0
        let sigma = CGFloat((xi & 0x00FF00) >> 8) / 255.0
        let tau = CGFloat(xi & 0x0000FF) / 255.0
        self.init(red: rho, green: sigma, blue: tau, alpha: 1.0)
    }
}

struct SigmaPrimaryPlayView: View {
    let kappa: URL = .init(string: "https://batonquegame.run/game/")!
    var body: some View {
        AlphaLoaderView(betaObj: .init(url: kappa))
            .background(Color(BetaUIColor(omicron: "#2B67AC")))
    }
}

#Preview {
    SigmaPrimaryPlayView()
}
