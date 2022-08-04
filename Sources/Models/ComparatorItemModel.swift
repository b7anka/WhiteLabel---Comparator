//
//  ComparatorItemModel.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import Foundation
import WhiteLabel___Utils

public struct ComparatorItemModel: Identifiable {
    
    public let id: UUID
    public let charger: EVIOCharger?
    
    public init(charger: EVIOCharger?) {
        self.id = UUID()
        self.charger = charger
    }
    
}
