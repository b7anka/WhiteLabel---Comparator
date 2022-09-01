//
//  ComparatorListView.swift
//  
//
//  Created by Tiago Moreira on 01/09/2022.
//

import SwiftUI

public struct ComparatorListView: View {
    
    @ObservedObject private var viewModel: ComparatorViewViewModel
    @Binding private var chargers: [ComparatorItemModel]
    
    public init(viewModel: ComparatorViewViewModel, chargers: Binding<[ComparatorItemModel]>) {
        self._chargers = chargers
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        LazyVGrid(columns: self.viewModel.columns, spacing: 10) {
            ForEach(self.chargers) { charger in
                ComparatorListItemView(item: charger, showChargerDetailsAction: { _ in}, showTariffInfo: { _ in}, deleteAction: self.viewModel.deleteCharger, selectCharger: self.viewModel.goToChargerSelection)
            } //: LIST
        } //: LAZYVGRID
        .padding(.horizontal, 34)
        .padding(.bottom, 20)
    }
    
}
