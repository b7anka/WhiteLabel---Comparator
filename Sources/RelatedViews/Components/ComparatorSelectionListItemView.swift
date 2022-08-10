//
//  ComparatorSelectionListItemView.swift
//  EVIO - WhiteLabel
//
//  Created by Tiago Moreira on 11/01/2022.
//

import SwiftUI
import Kingfisher
import WhiteLabel___Utils

public struct ComparatorSelectionListItemView: View {
    
    private let fav: ComparatorItemModel
    
    public init(fav: ComparatorItemModel) {
        self.fav = fav
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            ComparatorSelectionListItemMainView(fav: self.fav)
        }
        .background(Color.secondaryBackground)
        .cornerRadius(10)
        .shadow(color: .secondaryTextColor, radius: 3, x: 0, y: 2)
        .padding(.top, 5)
    }
    
}
