//
//  AdManager.swift
//  AdSdkDemo
//
//  Created by admin on 27/8/26.
//

import MoneyoyoAdSDK
import UIKit

public final class AdManager: NSObject, Sendable {

  @objc public static let shared = AdManager()

  @MainActor
  private var bannerAdView: BannerAdView?

  @objc public func initialize(appKey: String) {
    Task {
      do {
        try await AdSDK.initialize(appKey: appKey, isTest: true)
      } catch {
        print(error)
      }
    }
  }

  @objc public func loadBanner(
    zoneId: String,
    into container: UIView,
    completion: @escaping @Sendable (NSError?) -> Void
  ) {
    Task { @MainActor in
      do {
        let request = BannerAdRequest(size: BannerAdSizes.standard())
        request.enableAutoRefresh()
        let adView = try await request.load(zoneId: zoneId)
        show(adView, into: container)
        completion(nil)
      } catch {
        completion(error as NSError)
      }
    }
  }

  @MainActor
  @objc public func clearBanner() {
    bannerAdView?.destroy()
    bannerAdView?.removeFromSuperview()
    bannerAdView = nil
  }

  @MainActor
  private func show(_ adView: BannerAdView, into container: UIView) {
    clearBanner()
    bannerAdView = adView
    adView.backgroundColor = .white
    adView.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(adView)
    NSLayoutConstraint.activate([
      adView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      adView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      adView.topAnchor.constraint(equalTo: container.topAnchor),
      adView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
  }
}
