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
    
    public init(charger: ComparatorItemModel?) {
        self._viewModel = StateObject(wrappedValue: ChoosePlugViewViewModel(charger: charger))
    }
    
    public var body: some View {
        ZStack {
            Color.semiTransparent
                .edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.primaryBackground)
                .overlay(
                    VStack(spacing: 10) {
                        Text("Choose the plug you want to compare")
                            .modifier(EVIOAlertMessageModifier(color: .primaryTextColor, textAlignment: .center, lineLimit: nil))
                        ChoosePlugListView(viewModel: self.viewModel)
                        EVIOMainButton(disabled: self.$viewModel.okButtonDisabled, title: self.viewModel.languageManager.generalOk, action: self.viewModel.okButtonTapped)
                            .padding(.horizontal, 45)
                        Spacer()
                    }
                        .padding(10)
                )
                .padding(.horizontal, 15)
        }
        .background(EVIOTransparentBackgroundView())
    }
    
}
