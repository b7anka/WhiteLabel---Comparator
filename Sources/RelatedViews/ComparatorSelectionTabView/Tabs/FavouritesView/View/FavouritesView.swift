//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI

public struct FavouritesView: View {
    
    @StateObject private var viewModel: FavouritesViewViewModel
    
    public init() {
        self._viewModel = StateObject(wrappedValue: FavouritesViewViewModel())
    }
    
    public var body: some View {
        ComparatorSelectionListView(chargers: self.$viewModel.chargers, selectedCharger: self.viewModel.chargerSelected)
    }
}
