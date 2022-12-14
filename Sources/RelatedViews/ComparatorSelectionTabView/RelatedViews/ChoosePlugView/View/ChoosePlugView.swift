//
//  ChoosePlugView.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ChoosePlugView: View {
    
    @StateObject private var viewModel: ChoosePlugViewViewModel
    
    public init(charger: ComparatorItemModel?, plugSelected: @escaping (ComparatorItemModel) -> Void) {
        self._viewModel = StateObject(wrappedValue: ChoosePlugViewViewModel(charger: charger, plugSelected: plugSelected))
    }
    
    public var body: some View {
        ZStack {
            Color.semiTransparent
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: .zero) {
                VStack(spacing: 10) {
                    Text("Choose the plug you want to compare")
                        .modifier(EVIOAlertMessageModifier(color: .primaryTextColor, textAlignment: .center, lineLimit: 2))
                        .padding(10)
                    ChoosePlugListView(viewModel: self.viewModel)
                    EVIOMainButton(disabled: self.$viewModel.okButtonDisabled, title: self.viewModel.languageManager.generalOk, action: self.viewModel.okButtonTapped)
                        .padding(.horizontal, 55)
                        .padding(.bottom, 10)
                }
            }
            .background(Color.primaryBackground)
            .cornerRadius(20)
            .padding(.horizontal, 15)
            .padding(.vertical, UIScreen.main.bounds.height * 0.3)
        }
        .background(EVIOTransparentBackgroundView())
    }
    
}
