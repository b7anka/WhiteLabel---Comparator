//
//  ComparatorSelectionTabViewViewModel.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

final public class ComparatorSelectionTabViewViewModel: ObservableObject {
    
    public static let shared: ComparatorSelectionTabViewViewModel = ComparatorSelectionTabViewViewModel()
    
    @Published public var selectedItem: Int
    @Published public var isLoading: Bool
    
    public var tabs: [EVIOTabBarItem]
    public let languageManager: EVIOLanguage
    
    public init() {
        self.isLoading = false
        self.selectedItem = .zero
        self.languageManager = EVIOLanguageManager.shared.language
        self.tabs = [
            EVIOTabBarItem(title: self.languageManager.comparatorMyChargers),
            EVIOTabBarItem(title: self.languageManager.comparatorOtherChargers),
            EVIOTabBarItem(title: self.languageManager.comparatorFavourites)
        ]
    }
    
}
