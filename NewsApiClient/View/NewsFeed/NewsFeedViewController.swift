//
//  NewsFeedViewController.swift
//  NewsApiClient
//
//  Created by user on 17/06/2021.
//  Copyright © 2021 Artem Ulko. All rights reserved.
//

import UIKit

protocol ChangingCategoriesDelegat {
    func categoryHasChanged(category: NewsCategory, select: Bool) -> Void
}

final class NewsFeedViewController: UIViewController {
    
    private let nc = NotificationCenter.default
    private let viewModel: NewsFeedViewModel = .init()
    
    private let footerSpinner: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return activityIndicatorView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: NewsFeedTableViewCell.reuseIdentifier)
        tableView.register(CategoryViewCell.self, forCellReuseIdentifier: CategoryViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.tableFooterView = footerSpinner
        tableView.delegate = self
        tableView.dataSource = self
        footerSpinner.startAnimating()
        setupUI()
        setupObservers()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupObservers() {
        nc.addObserver(forName: .newsUpdated, object: viewModel, queue: .main) { [unowned self] _ in
            self.footerSpinner.stopAnimating()
            let indexSet: IndexSet = [1]
            self.tableView.reloadSections(indexSet, with: .none)
        }
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.reuseIdentifier, for: indexPath) as? CategoryViewCell else { fatalError() }
            cell.changingCategoriesDelegat = self
            cell.setup(selectedСategories: viewModel.selectedСategories)
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseIdentifier, for: indexPath) as? NewsFeedTableViewCell else {
                fatalError()
            }
            cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            return cell
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRowAt(section: indexPath.section, viewFrameHeight: view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isNewsLast(indexPath.row) && !viewModel.isLoading {
            footerSpinner.startAnimating()
            viewModel.loadMoreNews()
        }
    }
}

extension NewsFeedViewController: ChangingCategoriesDelegat {
    func categoryHasChanged(category: NewsCategory, select: Bool) {
        
        if select {
            viewModel.addCategory(category)
        } else {
            viewModel.removeCategory(category)
        }
    }
}
