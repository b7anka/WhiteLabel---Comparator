//
//  ComparatorViewViewModel.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class ComparatorViewViewModel: ObservableObject {
    
    // MARK: - PUBLISHED PROPERTIES
    @Published public var resetEvComponent: Bool
    @Published public var chargers: [ComparatorItemModel] {
        didSet {
            
        }
    }
    @Published public var showChargerSelection: Bool
    @Published public var sliderDuration: String
    
    // MARK: - PROPERTIEs
    public let languageManager: EVIOLanguage
    public var selectedEv: EVIOEv?
    public let goToEvs: (() -> Void)?
    public let columns: [GridItem]
    public let sliderViewModel: EVIOMultisliderViewModel
    public var chargingTime: Int
    
    // MARK: - INIT
    public init(goToEvs: (() -> Void)?) {
        self.chargingTime = .zero
        self.sliderDuration = .noValue
        self.showChargerSelection = false
        self.sliderViewModel = EVIOMultisliderViewModel(value: [0, 100], color: Color.sliderEnabledColor)
        self.goToEvs = goToEvs
        self.languageManager = EVIOLanguageManager.shared.language
        self.selectedEv = nil
        self.resetEvComponent = false
        self.columns  = [
            GridItem(.flexible(), alignment: .top),
            GridItem(.flexible(), alignment: .top)
        ]
        self.chargers = [ComparatorItemModel.´default´]
    }
    
    private func updateChargersValues() {
        for c in self.chargers where ((c.charger?.plugs?.first(where: { $0.selected })) != nil) {
            EVIOEstimatedCostUtils.shared.preSelectHalfHour(charger: c.charger, ev: self.selectedEv, sliderViewModel: self.sliderViewModel)
            self.calculateValues(value: self.sliderViewModel.value.last ?? .zero, item: c)
        }
    }
    
    private func calculateValues(value: CGFloat, item: ComparatorItemModel) {
        guard let ev = self.selectedEv else { return }
        var maxValue = value
        if Int(maxValue) == 0 {
            maxValue = 1
        }
        var maxPower: Double = 0.0
        var time: CGFloat!
        var plug: EVIOPlug?
        for c in self.chargers where ((c.charger?.plugs?.first(where: { $0.selected })) != nil) {
            if let selectedPlug = c.charger?.plugs?.first(where: { $0.selected }), maxPower == .zero || (selectedPlug.power ?? .zero) < maxPower {
                maxPower = selectedPlug.power ?? .zero
                plug = selectedPlug
            } else {
                continue
            }
        }
        guard let selectedPlug = plug else { return }
        let timeTo: CGFloat = EVIOAppUtils.shared.getValueForSliderBarSize(plug: selectedPlug, ev: ev, maxPower: maxPower, maxValue: maxValue)
        time = timeTo / 60.0
        guard let charger = item.charger, let estimateCost: EVIOEstimatedCost = EVIOEstimatedCostUtils.shared.calculateEstimatedCost(estimateTime: Double(timeTo / 60.0), contract: nil, charger: charger, plug: selectedPlug, ev: selectedEv) else {return}
        item.totalCost = String(format: "%.\((charger.isMobie ? estimateCost.estimatedCostForMobie?.priceWithTaxesButNoVat ?? 0.0 : estimateCost.mainCost).numberOfDecimalPlaces(maxPlaces: 2))f€", locale: Locale.current, charger.isMobie ? estimateCost.estimatedCostForMobie?.priceWithTaxesButNoVat ?? 0.0 : estimateCost.mainCost) + " \(self.languageManager.generalPlusVat)"
        item.totalPower = String(format: "%.\(estimateCost.consumption.numberOfDecimalPlaces(maxPlaces: 2))f %@", locale: Locale.current, estimateCost.consumption, self.languageManager.chargerDetailsKWh)
        let pricePerKwh = (charger.isMobie ? estimateCost.estimatedCostForMobie?.priceWithTaxesButNoVat ?? 0.0 : estimateCost.mainCost) / estimateCost.consumption
        item.averageCostPerKwh = String(format: "%.\(pricePerKwh.numberOfDecimalPlaces(maxPlaces: 4))f %@ %@", locale: Locale.current, pricePerKwh, "€/\(UOMS.kWh)", self.languageManager.generalPlusVat)
        let pricePerMin = (charger.isMobie ? estimateCost.estimatedCostForMobie?.priceWithTaxesButNoVat ?? 0.0 : estimateCost.mainCost) / Double(timeTo / 60.0)
        item.averageCostPerMinute = String(format: "%.\(pricePerMin.numberOfDecimalPlaces(maxPlaces: 4))f %@ %@", pricePerMin, "€/\(UOMS.min)", self.languageManager.generalPlusVat)
        self.chargingTime = Int(timeTo)
        self.sliderDuration = String(format: "%@ %@", TimeInterval(timeTo.rounded(.up)).timeAsString(showDays: false, showSeconds: false), time >= 60 ? "h" : "min")
    }
    
    // MARK: - PUBLIC FUNCTIONS
    public func evSelected(_ ev: EVIOEv?) {
        self.selectedEv = ev
    }
    
    public func goToChargerSelection() {
        self.showChargerSelection = true
    }
    
    public func deleteCharger(_ item: ComparatorItemModel) {
        self.chargers.removeAll(where: { $0.id == item.id })
        if self.chargers.count < .numberOfAllowedComparatorItems {
            if !self.chargers.contains(ComparatorItemModel.´default´) {
                self.chargers.append(ComparatorItemModel.´default´)
            }
        }
    }
    
}
