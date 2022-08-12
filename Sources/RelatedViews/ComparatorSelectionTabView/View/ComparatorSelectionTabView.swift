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
                    OtherChargersView(comparatorChargers: self.$comparatorChargers)
                default:
                    FavouritesView(comparatorChargers: self.$comparatorChargers)
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
            guard self.viewModel.closeView else { return }
            self.viewModel.closeView = false
            self.presentationMode.wrappedValue.dismiss()
        }
        .fullScreenCover(item: self.$viewModel.pageToPresent, onDismiss: nil) { page in
            ChoosePlugView(charger: self.viewModel.charger, plugSelected: self.viewModel.plugSelectedFor)
        }
        .onChange(of: self.viewModel.charger) { newValue in
            guard let charger = newValue else { return }
            self.comparatorChargers.insert(charger, at: self.comparatorChargers.count-1)
            if self.comparatorChargers.count > .numberOfAllowedComparatorItems {
                self.comparatorChargers.removeAll(where: { $0.isDefault })
            }
        }
    }
    
}
