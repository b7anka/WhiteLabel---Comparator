//
//  ComparatorItemModel.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class ComparatorItemModel: ObservableObject, Identifiable, Equatable {
    
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
    public init(id: UUID? = nil, charger: EVIOCharger?, isDefault: Bool = false) {
        self.isDefault = isDefault
        self.id = id ?? UUID()
        self.charger = charger
        self.totalCost = .noValue
        self.averageCostPerKwh = .noValue
        self.totalPower = .noValue
        self.averageCostPerMinute = .noValue
    }
    
    public static func == (lhs: ComparatorItemModel, rhs: ComparatorItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

public extension ComparatorItemModel {
    
    static let ´default´: ComparatorItemModel = ComparatorItemModel(charger: nil, isDefault: true)
    
    static func checkIfPlugOrChargerAlreadyExists(listOfChargers: [ComparatorItemModel], chargerToAdd: ComparatorItemModel) -> Bool {
        if listOfChargers.contains(where: { $0.charger?.id == chargerToAdd.charger?.id }) {
            for c in listOfChargers where c.charger?.id == chargerToAdd.charger?.id {
                for p in c.charger?.plugs ?? [] where p.selected {
                    for plug in chargerToAdd.charger?.plugs ?? [] where plug.selected {
                        if p.id == plug.id {
                            return true
                        }
                    }
                }
            }
            return false
        }
        return false
    }
    
}
