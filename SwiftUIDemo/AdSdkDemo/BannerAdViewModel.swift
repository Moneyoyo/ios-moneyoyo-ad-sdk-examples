import Combine
import MoneyoyoAdSDK
import SwiftUI

@MainActor
final class BannerAdViewModel: ObservableObject {
  @Published var adView: BannerAdView?
  @Published var errorMessage: String?

  func loadAd() async {
    do {
      let request = BannerAdRequest(size: BannerAdSizes.standard())
      request.enableAutoRefresh()
      self.adView = try await request.load(zoneId: Config.bannerZoneId)
    } catch {
      print(error)
      errorMessage = error.localizedDescription
    }
  }

  func destroy() {
    adView?.destroy()
    adView = nil
  }
}
