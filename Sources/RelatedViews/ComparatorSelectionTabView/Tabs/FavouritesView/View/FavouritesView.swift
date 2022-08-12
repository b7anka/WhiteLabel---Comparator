//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct FavouritesView: View {
    
    @StateObject private var viewModel: FavouritesViewViewModel
    @Binding private var comparatorChargers: [ComparatorItemModel]
    
    public init(comparatorChargers: Binding<[ComparatorItemModel]>) {
        self._comparatorChargers = comparatorChargers
        self._viewModel = StateObject(wrappedValue: FavouritesViewViewModel())
    }
    
    public var body: some View {
        ComparatorSelectionListView(chargers: self.$viewModel.chargers, selectedCharger: self.viewModel.chargerSelected)
            .onChange(of: self.viewModel.selectedCharger) { newValue in
                guard let charger = newValue else { return }
                if !ComparatorItemModel.checkIfPlugOrChargerAlreadyExists(listOfChargers: self.comparatorChargers, chargerToAdd: charger) {
                    self.comparatorChargers.insert(charger, at: self.comparatorChargers.count-1)
                } else {
                    EVIOLocalNotificationsManager.shared.showNotificationWithMessageAndTitle(self.viewModel.languageManager.comparatorPlugAlreadyBeingCompared, title: nil, style: .danger)
                }
                if self.comparatorChargers.count > .numberOfAllowedComparatorItems {
                    self.comparatorChargers.removeAll(where: { $0.isDefault })
                }
            }
    }
}
