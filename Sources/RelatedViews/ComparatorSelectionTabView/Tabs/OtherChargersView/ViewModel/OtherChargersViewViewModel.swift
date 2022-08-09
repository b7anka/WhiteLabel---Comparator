//
//  OtherChargersViewViewModel.swift
//  
//
//  Created by Tiago Moreira on 09/08/2022.
//

import SwiftUI
import WhiteLabel___Utils

public final class OtherChargersViewViewModel: ObservableObject {
    
    @Published public var chargers: [ComparatorItemModel]
    
    private var webService: ComparatorViewWebServiceProtocol
    
    public init(webService: ComparatorViewWebServiceProtocol = ComparatorViewWebService()) {
        self.webService = webService
        self.chargers = []
        self.getOtherChargers()
    }
    
    private func getOtherChargers() {
        ComparatorSelectionTabViewViewModel.shared.isLoading = true
        self.webService.getOtherInfastructures { chargers, serverMessage, _ in
            DispatchQueue.main.async { [weak self] in
                ComparatorSelectionTabViewViewModel.shared.isLoading = false
                guard let self = self else { return }
                if let chargers = chargers {
                    self.chargers = chargers.map({ ComparatorItemModel(charger: $0) })
                    #if DEBUG
                    guard self.chargers.isEmpty, let url: URL = Bundle.main.url(forResource: "charger", withExtension: .json), let data: Data = Data(contentsOf: url), let charger: EVIOCharger = try? JSONDecoder().decode(EVIOCharger.self, from: data) else { return }
                    self.chargers = [ComparatorItemModel(charger: charger)]
                    #endif
                } else if let serverMessage = serverMessage {
                    EVIOLocalNotificationsManager.shared.showNotificationWithMessageAndTitle(EVIOLanguageManager.shared.getTranslationFor(key: serverMessage.code ?? .empty), title: nil, style: .danger)
                } else {
                    EVIOLocalNotificationsManager.shared.showNotificationWithMessageAndTitle(EVIOLanguageManager.shared.language.generalGenericErrorMessage, title: nil, style: .danger)
                }
            }
        }
    }
    
}
