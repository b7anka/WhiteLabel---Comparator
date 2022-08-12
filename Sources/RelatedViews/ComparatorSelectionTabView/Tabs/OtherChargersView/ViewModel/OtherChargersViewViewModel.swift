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
    @Published public var selectedCharger: ComparatorItemModel?
    
    private var webService: ComparatorViewWebServiceProtocol
    
    public init(webService: ComparatorViewWebServiceProtocol = ComparatorViewWebService()) {
        self.selectedCharger = nil
        self.webService = webService
        self.chargers = []
        self.getOtherChargers()
    }
    
    func chargerSelected(_ item: ComparatorItemModel) {
        if item.charger?.plugs?.count ?? .zero > 1 {
            ComparatorSelectionTabViewViewModel.shared.charger = item
            UIView.withoutAnimation {
                ComparatorSelectionTabViewViewModel.shared.pageToPresent = .plugSelectionView
            }
            ComparatorSelectionTabViewViewModel.shared.plugChosenCompletion = { charger in
                self.selectedCharger = item
                ComparatorSelectionTabViewViewModel.shared.closeView = true
            }
        } else {
            self.selectedCharger = item
            ComparatorSelectionTabViewViewModel.shared.closeView = true
        }
    }
    
    private func getOtherChargers() {
        #if DEBUG
        guard self.chargers.isEmpty, let url: URL = Bundle.main.url(forResource: "other_chargers", withExtension: .json), let data: Data = try? Data(contentsOf: url), let chargers: [EVIOCharger] = try? JSONDecoder().decode([EVIOCharger].self, from: data) else { return }
        self.chargers = chargers.map({ ComparatorItemModel(charger: $0) })
        return
        #endif
        ComparatorSelectionTabViewViewModel.shared.isLoading = true
        self.webService.getOtherInfastructures { chargers, serverMessage, _ in
            DispatchQueue.main.async { [weak self] in
                ComparatorSelectionTabViewViewModel.shared.isLoading = false
                guard let self = self else { return }
                if let chargers = chargers {
                    self.chargers = chargers.map({ ComparatorItemModel(charger: $0) })
                } else if let serverMessage = serverMessage {
                    EVIOLocalNotificationsManager.shared.showNotificationWithMessageAndTitle(EVIOLanguageManager.shared.getTranslationFor(key: serverMessage.code ?? .empty), title: nil, style: .danger)
                } else {
                    EVIOLocalNotificationsManager.shared.showNotificationWithMessageAndTitle(EVIOLanguageManager.shared.language.generalGenericErrorMessage, title: nil, style: .danger)
                }
            }
        }
    }
    
}
