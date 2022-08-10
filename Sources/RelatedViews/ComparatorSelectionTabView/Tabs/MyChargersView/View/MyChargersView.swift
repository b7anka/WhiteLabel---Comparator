//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI

public struct MyChargersView: View {
    
    @StateObject private var viewModel: MyChargersViewViewModel
    @Binding private var comparatorChargers: [ComparatorItemModel]
    
    public init(comparatorChargers: Binding<[ComparatorItemModel]>) {
        self._comparatorChargers = comparatorChargers
        self._viewModel = StateObject(wrappedValue: MyChargersViewViewModel())
    }
    
    public var body: some View {
        ComparatorSelectionListView(chargers: self.$viewModel.chargers)
            .onChange(of: self.viewModel.selectedCharger) { newValue in
                guard let charger = newValue else { return }
                self.comparatorChargers.insert(charger, at: .zero)
            }
    }
    
}
