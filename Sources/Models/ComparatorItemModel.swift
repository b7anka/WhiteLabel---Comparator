//
//  ComparatorItemModel.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class ComparatorItemModel: ObservableObject, Identifiable {
    
    // MARK: - PUBLISHED PROPERTIES
    @Published public var totalCost: String
    @Published public var averageCostPerKwh: String
    @Published public var totalPower: String
    @Published public var averageCostPerMinute: String
    
    // MARK: - PROPERTIES
    public let id: UUID
    public let charger: EVIOCharger?
    public let isDefault: Bool
    
    // MARK: - COMPUTED PROPERTIES
    public var plugPower: String {
        guard let plug: EVIOPlug = self.charger?.plugs?.first(where: { $0.selected }), let power: Double = plug.power, power > .zero else { return .noValue }
        return String(format: "%.\(power.numberOfDecimalPlaces(maxPlaces: 1))f", locale: Locale.current, power)
    }
    
    // MARK: - INIT
    public init(charger: EVIOCharger?, isDefault: Bool = false) {
        self.isDefault = isDefault
        self.id = UUID()
        self.charger = charger
        self.totalCost = .empty
        self.averageCostPerKwh = .empty
        self.totalPower = .empty
        self.averageCostPerMinute = .empty
    }
    
}
