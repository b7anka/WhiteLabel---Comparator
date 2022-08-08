//
//  ComparatorListItemChargerInfoView.swift
//  
//
//  Created by Tiago Moreira on 08/08/2022.
//

import SwiftUI
import WhiteLabel___Utils
import Kingfisher

public struct ComparatorListItemChargerInfoView: View {
    
    // MARK: - PROPERTIES
    private let item: ComparatorItemModel
    private let languageManager: EVIOLanguage
    private let deleteAction: ((ComparatorItemModel) -> Void)
    private let feedbackGenerator: UIImpactFeedbackGenerator
    
    // MARK: - STATE PROPERTIES
    @State private var image: UIImage = UIImage(named: .placeHolderForChargerDetailsImage)!
    
    public init(item: ComparatorItemModel, deleteAction: @escaping (ComparatorItemModel) -> Void) {
        self.deleteAction = deleteAction
        self.feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        self.item = item
        self.languageManager = EVIOLanguageManager.shared.language
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            VStack(spacing: 5) {
                if self.item.charger == nil {
                    Text(self.languageManager.comparatorChooseChargingPoint)
                        .modifier(EVIOReferencePlaceAddressModifier(color: .secondaryTextColor.opacity(0.5), lineLimit: 1, textAlignment: .leading))
                } else {
                    HStack(spacing: .zero) {
                        EVIORating(rating: self.item.charger?.rating ?? .zero, starSize: .chargerSummaryAndDetailsRatingBarStarSize, starMargin: .chargerSummaryAndDetailsRatingBarStarMarging, isDisabled: true, size: .ratingStarSizeForChargerSummary, didUpdateRating: {_ in})
                        Spacer()
                    }
                }
                Text(self.item.charger?.name ?? self.languageManager.comparatorChargingPoint)
                    .modifier(EvioAvailabilityTitleFontModifier(color: .primaryTextColor, lineLimit: 1, textAlignment: .leading))
            } //: VSTACK
            .padding(5)
            if self.item.charger != nil {
                ZStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 122)
                        .clipShape(Rectangle())
                        .onAppear {
                            self.getImage()
                        } //: IMAGE
                    VStack(spacing: .zero) {
                        Spacer()
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
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                    } //: HSTACK
                } //: ZSTACK
                .frame(minWidth: 121, idealWidth: 165, maxWidth: 180, minHeight: 122, idealHeight: 122, maxHeight: 122)
            } else {
                Image(.comparatorAddChargerImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 122)
                    .clipShape(Rectangle())
                    .frame(minWidth: 121, idealWidth: 165, maxWidth: 180, minHeight: 122, idealHeight: 122, maxHeight: 122)
            }
        } //: VSTACK
        .background(
            Color.primaryBackground
        )
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: .zero, y: .zero)
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
