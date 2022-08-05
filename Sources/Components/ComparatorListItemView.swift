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
    private let showChargerDetailsAction: ((EVIOCharger?) -> Void)
    private let showTariffInfo: ((EVIOCharger?) -> Void)
    private let deleteAction: ((ComparatorItemModel) -> Void)
    private let feedbackGenerator: UIImpactFeedbackGenerator
    // MARK: - STATE PROPERTIES
    @State private var image: UIImage = UIImage(named: .placeHolderForChargerDetailsImage)!
    
    // MARK: - INIT
    public init(item: ComparatorItemModel, showChargerDetailsAction: @escaping (EVIOCharger?) -> Void, showTariffInfo: @escaping (EVIOCharger?) -> Void, deleteAction: @escaping (ComparatorItemModel) -> Void) {
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
            VStack(spacing: .zero) {
                VStack(spacing: 5) {
                    VStack(spacing: 5) {
                        if self.item.charger == nil {
                            Text(self.languageManager.comparatorChooseChargingPoint)
                                .modifier(EVIOReferencePlaceAddressModifier(color: .secondaryTextColor.opacity(0.5), lineLimit: 1, textAlignment: .leading))
                        } else {
                            EVIORating(isDisabled: true, didUpdateRating: { _ in })
                        }
                        Text(self.item.charger?.name ?? self.languageManager.comparatorChargingPoint)
                            .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
                    } //: VSTACK
                    .padding(5)
                    if self.item.charger != nil {
                        ZStack(alignment: .bottom) {
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: nil, height: 122)
                                .onAppear {
                                    self.getImage()
                                } //: IMAGE
                            HStack(spacing: .zero) {
                                Spacer()
                                Button(action: {
                                    self.feedbackGenerator.impactOccurred()
                                    self.deleteAction(self.item)
                                }) {
                                    Image(systemName: .trash)
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 15, height: 15)
                                }
                            } //: HSTACK
                        } //: ZSTACK
                    } else {
                        Image(.comparatorAddChargerImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: nil, height: 122)
                    }
                } //: VSTACK
            } //: VSTACK
            .background(
                Color.primaryBackground
            )
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: .zero, y: .zero)
            if self.item.charger != nil {
                VStack(alignment: .leading, spacing: 10) {
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
        } //: VSTACK
        .frame(minWidth: 150, maxWidth: 165)
    }
    
    // MARK: - FUNCTIONS
    private func getImage() {
        guard let parsedString: String = self.item.charger?.defaultImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url: URL = URL(string: parsedString) else { return }
        KingfisherManager.shared.retrieveImage(with: url) { result in
            if let image = try? result.get().image {
                self.image = image
            }
        }
    }
    
}
