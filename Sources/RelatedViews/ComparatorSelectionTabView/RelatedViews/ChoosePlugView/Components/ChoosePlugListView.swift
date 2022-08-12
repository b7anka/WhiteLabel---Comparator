//
//  ChoosePlugListView.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI

public struct ChoosePlugListView: View {
    
    @ObservedObject private var viewModel: ChoosePlugViewViewModel
    
    public init(viewModel: ChoosePlugViewViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(self.viewModel.plugs) { plug in
                        ChoosePlugListItemView(plug: plug, plugChosenCompletion: self.viewModel.plugChosen)
                    }
                }
                .frame(width: geo.size.width)
            }
        }
    }
    
}
