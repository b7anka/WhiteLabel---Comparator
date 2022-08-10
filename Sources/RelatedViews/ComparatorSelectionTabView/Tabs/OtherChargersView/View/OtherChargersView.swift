//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI

public struct OtherChargersView: View {
    
    @StateObject private var viewModel: OtherChargersViewViewModel
    
    public init() {
        self._viewModel = StateObject(wrappedValue: OtherChargersViewViewModel())
    }
    
    public var body: some View {
        ComparatorSelectionListView(chargers: self.$viewModel.chargers, selectedCharger: {_ in})
    }
    
}
