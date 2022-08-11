//
//  ChoosePlugViewViewModel.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI

public final class ChoosePlugViewViewModel: ObservableObject {
    
    public let charger: ComparatorItemModel?
    
    public init(charger: ComparatorItemModel?) {
        self.charger = charger
    }
    
}
