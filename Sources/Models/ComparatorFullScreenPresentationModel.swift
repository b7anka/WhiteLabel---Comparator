//
//  ComparatorFullScreenPresentationModel.swift
//  
//
//  Created by Tiago Moreira on 10/08/2022.
//

import Foundation

public enum ComparatorFullScreenPresentationModel: String, Identifiable {
    
    case plugSelectionView
    case mapSelection
    
    public var id: ComparatorFullScreenPresentationModel {
        return self
    }
    
}
