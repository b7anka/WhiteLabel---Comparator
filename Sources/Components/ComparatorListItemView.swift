//
//  ComparatorListItemView.swift
//  
//
//  Created by Tiago Moreira on 04/08/2022.
//

import SwiftUI
import WhiteLabel___Utils
import Kingfisher

public struct ComparatorListItemView: View {
    
    // MARK: - PROPERTIES
    private let item: ComparatorItemModel
    private let languageManager: EVIOLanguage
    private let deleteAction: ((ComparatorItemModel) -> Void)
    private let feedbackGenerator: UIImpactFeedbackGenerator
    // MARK: - STATE PROPERTIES
    @State private var image: UIImage = UIImage(named: .placeHolderForChargerDetailsImage)!
    
    // MARK: - INIT
    public init(item: ComparatorItemModel, deleteAction: @escaping (ComparatorItemModel) -> Void) {
        self.feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        self.deleteAction = deleteAction
        self.item = item
        self.languageManager = EVIOLanguageManager.shared.language
    }
    
    // MARK: - BODY
    public var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.primaryBackground)
            .overlay(
                VStack(spacing: 5) {
                    VStack(spacing: 5) {
                        if self.item.charger == nil {
                            Text(self.languageManager.comparatorChooseChargingPoint)
                        } else {
                            EVIORating(isDisabled: true, didUpdateRating: { _ in })
                        }
                        Text(self.item.charger?.name ?? .empty)
                    } //: VSTACK
                    .padding(5)
                    if self.item.charger != nil {
                        ZStack(alignment: .bottom) {
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: nil, height: 122)
                                .onAppear {
                                    self.getImage()
                                } //: IMAGE
                            HStack(spacing: .zero) {
                                Spacer()
                                Button(action: {
                                    self.feedbackGenerator.impactOccurred()
                                    self.deleteAction(self.item)
                                }) {
                                    Image(systemName: .trash)
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 15, height: 15)
                                }
                            } //: HSTACK
                        } //: ZSTACK
                    } else {
                        Image(.comparatorAddChargerImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: nil, height: 122)
                    }
                } //: VSTACK
            ) //: RECTANGLE
            .frame(width: 165, height: nil)
    }
    
    // MARK: - FUNCTIONS
    private func getImage() {
        guard let parsedString: String = self.item.charger?.defaultImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url: URL = URL(string: parsedString) else { return }
        KingfisherManager.shared.retrieveImage(with: url) { result in
            if let image = try? result.get().image {
                self.image = image
            }
        }
    }
    
}
