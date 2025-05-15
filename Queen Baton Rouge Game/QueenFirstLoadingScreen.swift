import SwiftUI
import Foundation

struct AlphaLoaderView: View {
    @StateObject var betaStateObj: GammaViewModel
    
    init(betaObj: GammaViewModel) {
        _betaStateObj = StateObject(wrappedValue: betaObj)
    }
    
    var body: some View {
        ZStack {
            DeltaGameHolder(vm: betaStateObj)
                .opacity(betaStateObj.omegaState == .loaded ? 1 : 0.5)
            if case .loading(let zeta) = betaStateObj.omegaState {
                GeometryReader { theta in
                    LambdaProgressView(progress: zeta)
                        .frame(width: theta.size.width, height: theta.size.height)
                        .background(Color.black)
                }
            } else if case .failed(let eta) = betaStateObj.omegaState {
                Text("Error: \(eta.localizedDescription)").foregroundColor(.red)
            } else if case .noInternet = betaStateObj.omegaState {
                Text("")
            }
        }
    }
}
