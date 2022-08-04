//
//  ComparatorViewViewModel.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class ComparatorViewViewModel: ObservableObject {
    
    public let languageManager: EVIOLanguage
    public var selectedEv: EVIOEv?
    @Published public var resetEvComponent: Bool
    public let goToEvs: (() -> Void)?
    
    public init(goToEvs: (() -> Void)?) {
        self.goToEvs = goToEvs
        self.languageManager = EVIOLanguageManager.shared.language
        self.selectedEv = nil
        self.resetEvComponent = false
    }
    
    public func evSelected(_ ev: EVIOEv?) {
        self.selectedEv = ev
    }
    
    
}
