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
    
    public init(charger: ComparatorItemModel?) {
        self.okButtonDisabled = true
        self.charger = charger
        self.languageManager = EVIOLanguageManager.shared.language
        self.parsePlugs()
    }
    
    public func okButtonTapped() {
        
    }
    
    public func plugChosen(_ plug: ChoosePlugModel) {
        self.plugs.forEach({
            if $0 == plug {
                $0.isSelected.toggle()
            } else {
                $0.isSelected = false
            }
        })
    }
    
    private func parsePlugs() {
        self.plugs = (self.charger?.charger?.plugs ?? []).map({ ChoosePlugModel(plug: $0) })
    }
    
}
