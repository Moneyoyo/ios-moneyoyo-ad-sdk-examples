//
//  ContentView.swift
//  AdSdkDemo
//
//  Created by admin on 26/8/26.
//

import MoneyoyoAdSDK
import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = BannerAdViewModel()

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text(Bundle.main.bundleIdentifier ?? "no")

      if let error = viewModel.errorMessage {
        Text(error)
          .font(.caption)
          .foregroundColor(.red)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
      }

      if let adView = viewModel.adView {
        BannerAdRepresentable(adView: adView)
          .fixedSize()
          .background(Color.black)
      }
    }
    .padding()
    .onAppear {
      Task {
        await viewModel.loadAd()
      }
    }
    .onDisappear {
      print("View disappeared. Cleaning up...")
      viewModel.destroy()
    }
  }
}

#Preview {
  ContentView()
}
