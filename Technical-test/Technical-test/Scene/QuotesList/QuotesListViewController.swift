//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

extension QuotesListViewController {
    
    convenience init(
        dataSource: DefaultQuotesListViewModel.DTO.DataSource,
        navigation: DefaultQuotesListViewModel.DTO.Navigation
    ) {
        self.init(
            viewModel: DefaultQuotesListViewModel(data: .init(
                related: .init(),
                source: dataSource,
                navigation: navigation
            ))
        )
    }
}

final class QuotesListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    private var viewModel: QuotesListViewModel!
    
    init(viewModel: QuotesListViewModel) {
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
    
    private func setupView() {
        navigationItem.title = viewModel.localizedTitle
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func bindViewModel() {
        viewModel.errorFetched.observe(on: self) { [weak self] errorMessage in
            self?.refreshControl.endRefreshing()
            let alertController = UIAlertController(
                title: self?.viewModel.defaultErrorAlertTitle,
                message: errorMessage,
                preferredStyle: .alert
            )
            alertController.addAction(.init(title: "OK", style: .default))
            self?.present(alertController, animated: true)
        }
        viewModel.listUpdated.observe(on: self) { [weak self] _ in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeAreaLayoutGuide()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(cell: QuoteCell.self)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        viewModel.refreshData()
    }
}

// MARK: - UITableViewDelegate
extension QuotesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowDidSeleted(with: indexPath)
    }
}
   
// MARK: - UITableViewDataSource
extension QuotesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.quoteCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(QuoteCell.self, for: indexPath)
        cell.setupView(from: viewModel.quote(by: indexPath))
        return cell
    }
}

