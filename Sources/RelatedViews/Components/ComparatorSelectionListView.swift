//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI

public struct ComparatorSelectionListView: View {
    
    @Binding private var chargers: [ComparatorItemModel]
    
    public init(chargers: Binding<[ComparatorItemModel]>) {
        self._chargers = chargers
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 10) {
                ForEach(self.chargers) { charger in
                    ComparatorSelectionListItemView(fav: charger)
                }
            }
            .padding(.horizontal, 34)
        }
        .padding(.top, 20)
    }
    
}
