//
//  ComparatorView.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorView: View {
    
    // MARK: - ENVIRONMENT PROPERTIEs
    @Environment(\.presentationMode) private var presentationMode
    // MARK: - STATE PROPERTIES
    @StateObject private var viewModel: ComparatorViewViewModel
    
    // MARK: - INIT
    public init(goToEvs: (() -> Void)? = nil) {
        self._viewModel = StateObject(wrappedValue: ComparatorViewViewModel(goToEvs: goToEvs))
    }
    
    // MARK: - BODY
    public var body: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                EVIOBackButtonAndTitleComponent(title: self.viewModel.languageManager.comparatorTitle) {
                    self.presentationMode.wrappedValue.dismiss()
                } //: BACK BUTTON COMPONENT
                .padding(.horizontal, 34)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        EVIOHorizontalEvSelectionView(selectedEv: self.viewModel.selectedEv, resetComponent: self.$viewModel.resetEvComponent, completion: self.viewModel.evSelected, popUpAction: self.viewModel.goToEvs)
                            .padding(.horizontal, 34)
                            .padding(.top, 10)
                        EVIOVerticalDivider()
                            .padding(.horizontal, 34)
                        ComparatorSliderView(sliderViewModel: self.viewModel.sliderViewModel)
                            .padding(.horizontal, 34)
                        LazyVGrid(columns: self.viewModel.columns, spacing: 10) {
                            ForEach(self.viewModel.chargers) { charger in
                                ComparatorListItemView(item: charger, showChargerDetailsAction: { _ in}, showTariffInfo: { _ in}, deleteAction: { _ in})
                            } //: LIST
                        } //: LAZYVGRID
                        .padding(.horizontal, 34)
                        .padding(.bottom, 20)
                    } //: VSTACK
                } //: SCROLLVIEW
            } //: VSTACK
        } //: ZSTACK
    }
    
}

