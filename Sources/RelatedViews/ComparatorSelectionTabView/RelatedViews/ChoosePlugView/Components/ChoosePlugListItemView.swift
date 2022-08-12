//
//  SwiftUIView.swift
//  
//
//  Created by Tiago Moreira on 11/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

struct ChoosePlugListItemView: View {
    
    @ObservedObject private var plug: ChoosePlugModel
    private let plugChosenCompletion: ((ChoosePlugModel) -> Void)
    private let feedbackGenerator: UIImpactFeedbackGenerator
    
    public init(plug: ChoosePlugModel, plugChosenCompletion: @escaping (ChoosePlugModel) -> Void) {
        self.plugChosenCompletion = plugChosenCompletion
        self._plug = ObservedObject(wrappedValue: plug)
        self.feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    }
    
    public var body: some View {
        Button(action: {
            self.feedbackGenerator.impactOccurred()
            self.plugChosenCompletion(self.plug)
        }) {
            VStack(spacing: 5) {
                Image(uiImage: UIImage(named: EVIOConnectorTypeHelper.shared.imageNameFor(plug: self.plug.plug, selected: self.plug.isSelected, backgroundOn: true, summary: false))!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: nil, height: 74)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: .gray.opacity(0.7), radius: 5, x: .zero, y: .zero)
                Text(String(format: "%.\((self.plug.plug?.power ?? .zero).numberOfDecimalPlaces(maxPlaces: 2))f kW", locale: Locale.current, self.plug.plug?.power ?? .zero))
                    .modifier(EvioFiltersSliderLabelsTextModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .center))
            }
        }
    }
    
}

