//
//  ComparatorSelectionListItemMainView.swift
//  EVIO - WhiteLabel
//
//  Created by Tiago Moreira on 12/01/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorSelectionListItemMainView: View {
    
    private let fav: ComparatorItemModel
    
    public init(fav: ComparatorItemModel) {
        self.fav = fav
    }
    
    public var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                ComparatorSelectionChargerImage(fav: self.fav)
                ComparatorSelectionChargerInfo(fav: self.fav)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            EVIOVerticalDivider()
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
        }
    }
    
}
