//
//  ComparatorListItemInfoRowView.swift
//  
//
//  Created by Tiago Moreira on 05/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorListItemInfoRowView: View {
    
    // MARK: - PROPERTIES
    private let title: String
    private let value: String
    private let boldText: Bool
    
    // MARK: - INIT
    public init(title: String, value: String, boldText: Bool = false) {
        self.title = title
        self.value = value
        self.boldText = boldText
    }
    
    // MARK: - BODY
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if self.boldText {
                Text(self.title)
                    .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
            } else {
                Text(self.title)
                    .modifier(EVIOReferencePlaceAddressModifier(color: .secondaryTextColor, lineLimit: 1, textAlignment: .leading))
            }
            Text(self.value)
                .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
        } //: VSTACK
    }
    
}
