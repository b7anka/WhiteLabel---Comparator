//
//  ChoosePlugModel.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class ChoosePlugModel: ObservableObject, Identifiable {
    
    @Published var isSelected: Bool
    public let id: UUID
    public let plug: EVIOPlug?
    
    public init(plug: EVIOPlug?) {
        self.id = UUID()
        self.plug = plug
        self.isSelected = false
    }
    
    
}

