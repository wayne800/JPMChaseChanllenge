//
//  TableViewDataSource.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation
import UIKit

protocol TableViewDataProvider {
    associatedtype DataObject
    
    func numberOfItemsInSection(_ section: Int) -> Int
    func objectAtIndexPath(indexPath: IndexPath) -> DataObject
}

public protocol ConfigurableCell {
    associatedtype DataObject

    func configure(for object: DataObject)
}

final class TableViewDataSource<Provider: TableViewDataProvider, Cell: UITableViewCell>: NSObject, UITableViewDataSource where Cell: ConfigurableCell, Provider.DataObject == Cell.DataObject {
    
    private var tableView: UITableView
    private var provider: Provider
    
    init(tableView: UITableView, provider: Provider) {
        self.tableView = tableView
        self.provider = provider
        
        tableView.register(cell: Cell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: Cell.self, for: indexPath)
        cell.configure(for: provider.objectAtIndexPath(indexPath: indexPath))
        return cell
    }
}
