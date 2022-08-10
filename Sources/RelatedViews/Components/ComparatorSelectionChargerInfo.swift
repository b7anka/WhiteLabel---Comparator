//
//  ComparatorSelectionChargerInfo.swift
//  EVIO - WhiteLabel
//
//  Created by Tiago Moreira on 12/01/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorSelectionChargerInfo: View {
    
    private let fav: ComparatorItemModel
    
    public init(fav: ComparatorItemModel) {
        self.fav = fav
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(self.fav.charger?.name ?? String.noValue)
                .modifier(EVIOMainFontModifier())
            Text(self.fav.charger?.address?.toString() ?? String.noValue)
                .modifier(EVIOChargerAddressModifier())
        }
    }
    
}
