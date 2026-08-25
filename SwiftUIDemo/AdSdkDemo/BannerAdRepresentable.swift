import MoneyoyoAdSDK
import SwiftUI

struct BannerAdRepresentable: UIViewRepresentable {
    let adView: BannerAdView

    func makeUIView(context: Context) -> BannerAdView {
        adView.backgroundColor = .white
        return adView
    }

    func updateUIView(_ uiView: BannerAdView, context: Context) {}
}