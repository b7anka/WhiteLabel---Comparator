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
                    EVIOHorizontalEvSelectionView(selectedEv: self.viewModel.selectedEv, resetComponent: self.$viewModel.resetEvComponent, completion: self.viewModel.evSelected, popUpAction: self.viewModel.goToEvs)
                        .padding(.horizontal, 34)
                        .padding(.top, 10)
                } //: EV SELECTION VIEW
                .padding(.bottom, 20)
            } //: SCROLLVIEW
        } //: ZSTACK
    }
    
}

// MARK: - PREVIEW
public struct ComparatorTabView_Previews: PreviewProvider {
    public static var previews: some View {
        ComparatorView()
    }
}
