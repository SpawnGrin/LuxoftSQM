//
//  QuoteCell.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import UIKit

final class QuoteCell: UITableViewCell {
    
    struct DTO {
        let name: String?
        let rate: String?
        let percentage: String?
        let percentColor: UIColor
        let isFavorite: Bool
    }
    
    private let nameLabel = UILabel()
    private let rateLabel = UILabel()
    private let percentLabel = UILabel()
    private let favoriteImageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = String()
        rateLabel.text = String()
        percentLabel.text = String()
        favoriteImageView.image = nil
    }
    
    public func setupView(from data: DTO) {
        selectionStyle = .none
        
        setupNameLabel()
        setupRateLabel()
        setupPercentLabel()
        setupImageView()
        
        fillCell(from: data)
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            padding: .init(top: 8, left: 16, bottom: 0, right: 0)
        )
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupRateLabel() {
        addSubview(rateLabel)
        rateLabel.anchor(
            top: nameLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 4, left: 16, bottom: 8, right: 0)
        )
    }
    
    private func setupPercentLabel() {
        addSubview(percentLabel)
        percentLabel.textAlignment = .right
        percentLabel.centerYTo(centerYAnchor)
        percentLabel.anchor(
            leading: nameLabel.trailingAnchor,
            padding: .init(top: 0, left: 8, bottom: 0, right: 0)
        )
        percentLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    private func setupImageView() {
        addSubview(favoriteImageView)
        favoriteImageView.centerYTo(centerYAnchor)
        favoriteImageView.anchor(
            leading: percentLabel.trailingAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16),
            size: .init(same: 32)
        )
    }
    
    private func fillCell(from data: DTO) {
        nameLabel.text = data.name
        rateLabel.text = data.rate
        percentLabel.text = data.percentage
        percentLabel.textColor = data.percentColor
        favoriteImageView.image = data.isFavorite ? Image.favorite : Image.notFavorite
    }
}

extension QuoteCell.DTO {
    init(from quote: Quote) {
        self.name = quote.name
        self.rate = "\(quote.lastValue ?? "-") \(quote.currency ?? "")"
        self.percentage = quote.lastPercent
        self.percentColor = quote.percentColor.value
        self.isFavorite = quote.isFavorite
    }
}
