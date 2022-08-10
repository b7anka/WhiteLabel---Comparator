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
    @Published public var chargers: [ComparatorItemModel]
    @Published public var showChargerSelection: Bool
    
    // MARK: - PROPERTIEs
    public let languageManager: EVIOLanguage
    public var selectedEv: EVIOEv?
    public let goToEvs: (() -> Void)?
    public let columns: [GridItem]
    public let sliderViewModel: EVIOMultisliderViewModel
    
    // MARK: - INIT
    public init(goToEvs: (() -> Void)?) {
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
        #if DEBUG
        guard let url = Bundle.main.url(forResource: "charger", withExtension: .json), let data: Data = try? Data(contentsOf: url), let charger: EVIOCharger = try? JSONDecoder().decode(EVIOCharger.self, from: data) else { return }
        self.chargers.insert(ComparatorItemModel(charger: charger), at: .zero)
        #endif
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
    }
    
}
