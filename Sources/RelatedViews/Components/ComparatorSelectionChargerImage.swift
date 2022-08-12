//
//  ComparatorSelectionChargerImage.swift
//  EVIO - WhiteLabel
//
//  Created by Tiago Moreira on 12/01/2022.
//

import SwiftUI
import WhiteLabel___Utils

public struct ComparatorSelectionChargerImage: View {
    
    private let fav: ComparatorItemModel
    
    public init(fav: ComparatorItemModel) {
        self.fav = fav
    }
    
    public var body: some View {
        if let urlString: String = self.fav.charger?.defaultImage {
            EVIOImage(urlString: urlString, defaultImage: .chargerDefaultIcon, aspectRatio: .fit size: CGSize.init(width: 62, height: 62))
                .clipShape(Circle())
                      
        } else {
            EVIOImage(urlString: (self.fav.charger?.imageContent?.first ?? .empty) ?? .empty, defaultImage: .chargerDefaultIcon, aspectRatio: .fit, size: CGSize.init(width: 62, height: 62))
                .clipShape(Circle())
        }
    }
    
}
