//
//  ChoosePlugView.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI

public struct ChoosePlugView: View {
    
    @StateObject private var viewModel: ChoosePlugViewViewModel
    
    public init(charger: ComparatorItemModel?) {
        self._viewModel = StateObject(wrappedValue: ChoosePlugViewViewModel(charger: charger))
    }
    
    public var body: some View {
        Text("Hello, World!")
    }
    
}
