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
    
    // MARK: - PROPERTIEs
    public let languageManager: EVIOLanguage
    public var selectedEv: EVIOEv?
    public let goToEvs: (() -> Void)?
    
    // MARK: - INIT
    public init(goToEvs: (() -> Void)?) {
        self.goToEvs = goToEvs
        self.languageManager = EVIOLanguageManager.shared.language
        self.selectedEv = nil
        self.resetEvComponent = false
        self.chargers = [ComparatorItemModel.´default´]
    }
    
    // MARK: - PUBLIC FUNCTIONS
    public func evSelected(_ ev: EVIOEv?) {
        self.selectedEv = ev
    }
    
    
}
