//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorSelectionTabView: View {
    
    @StateObject private var viewModel: ComparatorSelectionTabViewViewModel
    
    public init() {
        self._viewModel = StateObject(wrappedValue: ComparatorSelectionTabViewViewModel.shared)
    }
    
    public var body: some View {
        ZStack {
            Color.primaryBackground
                .edgesIgnoringSafeArea(.all)
            EVIOTabBarViewController(selectedTab: self.$viewModel.selectedItem, title: nil, tabs: self.viewModel.tabs, allowSwipeToChangeTabs: false) {
                switch self.viewModel.selectedItem {
                case .zero:
                    MyChargersView()
                case 1:
                    OtherChargersView()
                default:
                    FavouritesView()
                }
            }
            if self.viewModel.isLoading {
                EVIOLoadingView(transparent: true)
            }
        }
        .disabled(self.viewModel.isLoading)
        .navigationTitle(String.empty)
        .navigationBarHidden(true)
    }
    
}
