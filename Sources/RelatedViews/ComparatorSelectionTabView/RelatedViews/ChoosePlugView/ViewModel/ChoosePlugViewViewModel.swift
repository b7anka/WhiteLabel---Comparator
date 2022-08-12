//
//  ChoosePlugViewViewModel.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class ChoosePlugViewViewModel: ObservableObject {
    
    @Published public var okButtonDisabled: Bool
    @Published public var plugs: [ChoosePlugModel]
    public let charger: ComparatorItemModel?
    public let languageManager: EVIOLanguage
    private var plugSelected: ((ComparatorItemModel) -> Void)
    
    public init(charger: ComparatorItemModel?, plugSelected: @escaping (ComparatorItemModel) -> Void) {
        self.plugSelected = plugSelected
        self.plugs = []
        self.okButtonDisabled = true
        self.charger = charger
        self.languageManager = EVIOLanguageManager.shared.language
        self.parsePlugs()
    }
    
    public func okButtonTapped() {
        guard let charger = charger, let selectedPlug: EVIOPlug = self.plugs.first(where: { $0.isSelected })?.plug, let index = charger.charger?.plugs?.firstIndex(of: selectedPlug) else {
            return
        }
        selectedPlug.selected = true
        charger.charger?.plugs[index] = selectedPlug
        self.plugSelected(charger)
        ComparatorSelectionTabViewViewModel.shared.pageToPresent = nil
        ComparatorSelectionTabViewViewModel.shared.closeView = true
    }
    
    public func plugChosen(_ plug: ChoosePlugModel) {
        self.plugs.forEach({
            if $0.id == plug.id {
                $0.isSelected.toggle()
            } else {
                $0.isSelected = false
            }
        })
        self.checkIfOkbuttonShouldBeEnabled()
    }
    
    private func parsePlugs() {
        self.plugs = (self.charger?.charger?.plugs ?? []).map({ ChoosePlugModel(plug: $0) })
    }
    
    private func checkIfOkbuttonShouldBeEnabled() {
        withAnimation {
            let selectedPlug: ChoosePlugModel? = self.plugs.first(where: { $0.isSelected })
            self.okButtonDisabled = selectedPlug == nil
        }
    }
    
}
