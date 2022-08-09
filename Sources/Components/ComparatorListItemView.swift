//
//  ComparatorListItemView.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils
import Kingfisher

public struct ComparatorListItemView: View {
    
    // MARK: - PROPERTIES
    private let item: ComparatorItemModel
    private let languageManager: EVIOLanguage
    private let selectCharger: (() -> Void)
    private let showChargerDetailsAction: ((EVIOCharger?) -> Void)
    private let showTariffInfo: ((EVIOCharger?) -> Void)
    private let deleteAction: ((ComparatorItemModel) -> Void)
    private let feedbackGenerator: UIImpactFeedbackGenerator
    
    // MARK: - INIT
    public init(item: ComparatorItemModel, showChargerDetailsAction: @escaping (EVIOCharger?) -> Void, showTariffInfo: @escaping (EVIOCharger?) -> Void, deleteAction: @escaping (ComparatorItemModel) -> Void, selectCharger: @escaping () -> Void) {
        self.selectCharger = selectCharger
        self.feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        self.showChargerDetailsAction = showChargerDetailsAction
        self.showTariffInfo = showTariffInfo
        self.deleteAction = deleteAction
        self.item = item
        self.languageManager = EVIOLanguageManager.shared.language
    }
    
    // MARK: - BODY 
    public var body: some View {
        VStack(spacing: 10) {
            ComparatorListItemChargerInfoView(item: self.item, selectCharger: self.selectCharger, deleteAction: self.deleteAction)
            if self.item.charger != nil {
                ComparatorListItemChargerCostView(item: self.item, showTariffInfo: self.showTariffInfo)
            }
        } //: VSTACK
    }
}
