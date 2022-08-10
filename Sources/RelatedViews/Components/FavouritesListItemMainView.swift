//
//  FavouritesListItemMainView.swift
//  EVIO - WhiteLabel
//
//  Created by Tiago Moreira on 12/01/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct FavouritesListItemMainView: View {
    
    private let fav: ComparatorItemModel
    
    public init(fav: ComparatorItemModel) {
        self.fav = fav
    }
    
    public var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                FavouritesChargerImage(fav: self.fav)
                FavouritesChargerInfo(fav: self.fav)
                Spacer()
            }
            .padding(.horizontal, 10)
            EVIOVerticalDivider()
                .padding([.horizontal, .vertical], 5)
        }
    }
    
}
