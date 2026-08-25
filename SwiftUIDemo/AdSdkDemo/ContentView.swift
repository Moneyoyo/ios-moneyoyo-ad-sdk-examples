//
//  ContentView.swift
//  AdSdkDemo
//
//  Created by admin on 26/8/26.
//

import MoneyoyoAdSDK
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AdViewModel()

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
                .task {
            await viewModel.loadAd()
        }
    }
}


#Preview {
    ContentView()
}
