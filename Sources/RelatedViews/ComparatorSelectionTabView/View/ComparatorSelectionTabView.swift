//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorSelectionTabView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel: ComparatorSelectionTabViewViewModel
    @Binding private var comparatorChargers: [ComparatorItemModel]
    
    public init(comparatorChargers: Binding<[ComparatorItemModel]>) {
        self._comparatorChargers = comparatorChargers
        self._viewModel = StateObject(wrappedValue: ComparatorSelectionTabViewViewModel.shared)
    }
    
    public var body: some View {
        ZStack {
            Color.primaryBackground
                .edgesIgnoringSafeArea(.all)
            EVIOTabBarViewController(selectedTab: self.$viewModel.selectedItem, title: nil, tabs: self.viewModel.tabs, allowSwipeToChangeTabs: false) {
                switch self.viewModel.selectedItem {
                case .zero:
                    MyChargersView(comparatorChargers: self.$comparatorChargers)
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
        .onChange(of: self.viewModel.closeView) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
