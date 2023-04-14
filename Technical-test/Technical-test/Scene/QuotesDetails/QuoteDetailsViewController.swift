//
//  QuoteDetailsViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

extension QuoteDetailsViewController {
    
    convenience init(related: DefaultQuoteDetailsViewModel.DTO.Related) {
        self.init(
            viewModel: DefaultQuoteDetailsViewModel(data: .init(related: related))
        )
    }
}

final class QuoteDetailsViewController: UIViewController {
    
    private let readableLastChangePercentLabel = UILabel()
    private let favoriteButton = UIButton()
    private let currencyLabel = UILabel()
    private let symbolLabel = UILabel()
    private let nameLabel = UILabel()
    private let lastLabel = UILabel()
    
    private var viewModel: QuoteDetailsViewModel!
    private lazy var safeArea = view.safeAreaLayoutGuide
    
    init(viewModel: QuoteDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
    
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.favoriteButtonTitleUpdated.observe(on: self) { [favoriteButton] title in
            favoriteButton.setTitle(title, for: .normal)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        addSubviews()
        setupSymbolLabel()
        setupNameLabel()
        setupLastLabel()
        setupCurrencyLabel()
        setupPercentLabel()
        setupFavoriteButton()
    }
    
    private func addSubviews() {
        view.addSubview(symbolLabel)
        view.addSubview(nameLabel)
        view.addSubview(lastLabel)
        view.addSubview(currencyLabel)
        view.addSubview(readableLastChangePercentLabel)
        view.addSubview(favoriteButton)
    }
    
    private func setupSymbolLabel() {
        symbolLabel.textAlignment = .center
        symbolLabel.font = .boldSystemFont(ofSize: 40)
        symbolLabel.text = viewModel.symbol
        symbolLabel.anchor(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 32, left: 16, bottom: 0, right: 16)
        )
    }
    
    private func setupNameLabel() {
        nameLabel.text = viewModel.name
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 30)
        nameLabel.textColor = .lightGray
        nameLabel.anchor(
            top: symbolLabel.bottomAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 8, left: 16, bottom: 0, right: 16)
        )
    }
    
    private func setupLastLabel() {
        lastLabel.text = viewModel.lastValue
        lastLabel.textAlignment = .right
        lastLabel.font = .systemFont(ofSize: 30)
        lastLabel.anchor(
            top: nameLabel.bottomAnchor,
            leading: safeArea.leadingAnchor,
            padding: .init(top: 8, left: 16, bottom: 0, right: 8)
        )
    }
    
    private func setupCurrencyLabel() {
        currencyLabel.text = viewModel.currency
        currencyLabel.font = .systemFont(ofSize: 15)
        currencyLabel.anchor(
            leading: lastLabel.trailingAnchor,
            trailing: safeArea.centerXAnchor,
            padding: .init(top: 0, left: 4, bottom: 0, right: 4)
        )
        currencyLabel.centerYTo(lastLabel.centerYAnchor)
    }
    
    private func setupPercentLabel() {
        readableLastChangePercentLabel.text = viewModel.lastPercent
        readableLastChangePercentLabel.textColor = viewModel.percentColor.value
        readableLastChangePercentLabel.textAlignment = .center
        readableLastChangePercentLabel.layer.cornerRadius = 8
        readableLastChangePercentLabel.layer.masksToBounds = true
        readableLastChangePercentLabel.layer.borderWidth = 1
        readableLastChangePercentLabel.layer.borderColor = UIColor.black.cgColor
        readableLastChangePercentLabel.font = .systemFont(ofSize: 30)
        readableLastChangePercentLabel.anchor(
            top: nameLabel.bottomAnchor,
            leading: safeArea.centerXAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 8, left: 4, bottom: 0, right: 16)
        )
    }
    
    private func setupFavoriteButton() {
        favoriteButton.setTitle(viewModel.buttonTitle, for: .normal)
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.layer.masksToBounds = true
        favoriteButton.layer.borderWidth = 1
        favoriteButton.layer.borderColor = UIColor.black.cgColor
        favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
        favoriteButton.setTitleColor(.black, for: .normal)
        favoriteButton.anchor(
            top: readableLastChangePercentLabel.bottomAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 24, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
    }
    
    @objc private func didPressFavoriteButton() {
        viewModel.favotiteAction()
    }
}
