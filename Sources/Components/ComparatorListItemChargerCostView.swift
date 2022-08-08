//
//  ComparatorListItemChargerCostView.swift
//  
//
//  Created by Tiago Moreira on 08/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorListItemChargerCostView: View {
    
    // MARK: - PROPERTIES
    private let item: ComparatorItemModel
    private let languageManager: EVIOLanguage
    private let showTariffInfo: ((EVIOCharger?) -> Void)
    private let feedbackGenerator: UIImpactFeedbackGenerator
    
    // MARK: - INIT
    public init(item: ComparatorItemModel, showTariffInfo: @escaping (EVIOCharger?) -> Void) {
        self.showTariffInfo = showTariffInfo
        self.item = item
        self.languageManager = EVIOLanguageManager.shared.language
        self.feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    }
    
    // MARK: - BODY
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Button(action: {
                self.feedbackGenerator.impactOccurred()
                self.showTariffInfo(self.item.charger)
            }) {
                HStack(spacing: 5) {
                    Text(self.languageManager.comparatorTotalCost)
                        .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
                    EVIOInformationIconView()
                } //: HSTACK
            } //: BUTTON
            Text("\(self.item.totalCost)€ \(self.languageManager.generalPlusVat)")
                .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
            ComparatorListItemInfoRowView(title: UOMS.kWh, value: self.item.totalPower)
            Text(self.languageManager.comparatorAverageCost)
                .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
            ComparatorListItemInfoRowView(title: "€/\(UOMS.kWh)", value: "\(self.item.averageCostPerKwh) €/\(UOMS.kWh) \(self.languageManager.generalPlusVat)")
            ComparatorListItemInfoRowView(title: "€/\(UOMS.min) \(self.languageManager.generalPlusVat)", value: "\(self.item.averageCostPerMinute) €/\(UOMS.min) \(self.languageManager.generalPlusVat)")
            
        } //: VSTACK
    }
    
}
