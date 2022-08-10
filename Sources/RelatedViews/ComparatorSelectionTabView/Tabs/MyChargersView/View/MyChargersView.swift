//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI

public struct MyChargersView: View {
    
    @StateObject private var viewModel: MyChargersViewViewModel
    
    public init() {
        self._viewModel = StateObject(wrappedValue: MyChargersViewViewModel())
    }
    
    public var body: some View {
        ComparatorSelectionListView(chargers: self.$viewModel.chargers)
    }
    
}
