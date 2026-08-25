import Combine
import MoneyoyoAdSDK
import SwiftUI

@MainActor
final class AdViewModel: ObservableObject {
    @Published var adView: BannerAdView?
    @Published var errorMessage: String?

    private let appKey = "<REPLACE_APP_KEY_HERE>"
    private let zoneID = "<REPLACE_ZONE_ID_HERE>"

    func loadAd() async {
        do {
            try await AdSDK.initialize(appKey: appKey, isTest: true)
            let request = BannerAdRequest(size: BannerAdSizes.standard())
            request.enableAutoRefresh()
            self.adView = try await request.load(zoneId: zoneID)
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}