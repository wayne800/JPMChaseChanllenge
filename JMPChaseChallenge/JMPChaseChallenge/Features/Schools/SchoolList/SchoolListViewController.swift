//
//  SchoolListViewController.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Combine
import UIKit

class SchoolListViewController: BaseViewController {

    // MARK: properties
    var viewModel: SchoolListViewModelType?
    weak var coordinator: SchoolListCoodinatorType?
    
    // MARK: private properties
    private let tableView = UITableView()
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: TableViewDataSource<SchoolListViewModel, SchoolListTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupSubscriptions()
    }

    private func setupViews() {
        title = "Schools List"
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorInset = UIEdgeInsets(top: 0, left: UIConstants.mrginTiny, bottom: 0, right: UIConstants.mrginTiny)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupSubscriptions() {
        dataSource = .init(tableView: tableView,
                           provider: viewModel as! SchoolListViewModel)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        viewModel?.outputs.isLoadingData
            .sink(receiveValue: {[weak self] isLoading in
                self?.shouldDisplayIndicator(display: isLoading)
            })
            .store(in: &cancellables)
        
        viewModel?.outputs.schoolsItems
            .sink(receiveCompletion: {[weak self] event in
                switch event {
                case .failure(let err):
                    self?.coordinator?.input.coordinateToAlert(with: err.localizedDescription)
                default:
                    break
                }
            }, receiveValue: {[weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
        
        viewModel?.outputs.schoolsDetailItem
            .sink(receiveCompletion: {[weak self] event in
                switch event {
                case .failure(let err):
                    self?.coordinator?.input.coordinateToAlert(with: err.localizedDescription)
                default:
                    break
                }
            }, receiveValue: {[weak self] selectedModel in
                self?.coordinator?.input.coordinateToDetail(with: selectedModel)
            })
            .store(in: &cancellables)
        
        viewModel?.outputs.errorInfo
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] err in
                self?.coordinator?.input.coordinateToAlert(with: err.localizedDescription)
                self?.shouldDisplayIndicator(display: false)
            })
            .store(in: &cancellables)
        
        viewModel?.inputs.fetchShools()
    }
}

extension SchoolListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.inputs.selected(with: indexPath)
    }
}
