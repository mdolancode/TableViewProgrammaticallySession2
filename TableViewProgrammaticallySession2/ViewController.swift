//
//  ViewController.swift
//  TableViewProgrammaticallySession2
//
//  Created by Matthew Dolan on 2024-11-28.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var visibleCellCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        tableViewConstraints()
        registerCell()
        
        updateCellCountInNavigationTitle()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func registerCell() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    func updateCellCountInNavigationTitle() {
        title = "Visible Cells: \(visibleCellCount)"
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.label.text = "Row: \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        visibleCellCount += 1
        print("Will display cell at row: \(indexPath.row)")
        
        updateCellCountInNavigationTitle()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if visibleCellCount > 0 {
            visibleCellCount -= 1
        }
        
        print("Did end displaying cell at row: \(indexPath.row)")
        
        updateCellCountInNavigationTitle()
    }
}

