//
//  ViewController.swift
//  AdSdkDemo
//
//  Created by admin on 26/8/26.
//

import MoneyoyoAdSDK
import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var bundleLabel: UILabel!
  @IBOutlet private weak var errorLabel: UILabel!
  @IBOutlet private weak var bannerContainer: UIView!

  private var bannerAdView: BannerAdView?

  override func viewDidLoad() {
    super.viewDidLoad()

    bundleLabel.text = Bundle.main.bundleIdentifier ?? "no"
    errorLabel.isHidden = true
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Task {
      await loadAd()
    }
  }

  private func loadAd() async {
    do {
      let request = BannerAdRequest(size: BannerAdSizes.standard())
      request.enableAutoRefresh()
      let adView = try await request.load(zoneId: Config.bannerZoneId)
      showBanner(adView)
    } catch {
      print(error)
      showError(error.localizedDescription)
    }
  }

  private func showBanner(_ adView: BannerAdView) {
    bannerAdView?.removeFromSuperview()
    bannerAdView = adView
    adView.backgroundColor = .white
    adView.translatesAutoresizingMaskIntoConstraints = false
    bannerContainer.addSubview(adView)
    NSLayoutConstraint.activate([
      adView.leadingAnchor.constraint(equalTo: bannerContainer.leadingAnchor),
      adView.trailingAnchor.constraint(equalTo: bannerContainer.trailingAnchor),
      adView.topAnchor.constraint(equalTo: bannerContainer.topAnchor),
      adView.bottomAnchor.constraint(equalTo: bannerContainer.bottomAnchor),
    ])
  }

  private func showError(_ message: String) {
    errorLabel.text = message
    errorLabel.isHidden = false
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    bannerAdView?.destroy()
    bannerAdView = nil
  }
}
