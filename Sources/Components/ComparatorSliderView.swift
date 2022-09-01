//
//  ComparatorSliderView.swift
//  
//
//  Created by Tiago Moreira on 08/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorSliderView: View {
    
    @Binding private var duration: String
    @ObservedObject private var sliderViewModel: EVIOMultisliderViewModel
    private let languageManager: EVIOLanguage
    
    public init(duration: Binding<String>, sliderViewModel: EVIOMultisliderViewModel) {
        self._duration = duration
        self._sliderViewModel = ObservedObject(wrappedValue: sliderViewModel)
        self.languageManager = EVIOLanguageManager.shared.language
    }
    
    public var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: .zero) {
                Text(self.languageManager.comparatorChargingDuration)
                    .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
                Spacer()
            }
            EVIOMultiSlider(viewModel: self.sliderViewModel)
            HStack(spacing: .zero) {
                Text(self.duration)
                    .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
                Spacer()
            }
        }
    }
    
}

