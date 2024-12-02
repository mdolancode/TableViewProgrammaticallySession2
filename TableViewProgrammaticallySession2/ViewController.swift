//
//  ViewController.swift
//  TableViewProgrammaticallySession2
//
//  Created by Matthew Dolan on 2024-11-28.
//

import UIKit

// MARK: - Main ViewController for displaying a table view programmatically
class ViewController: UIViewController {

    // UITableView instance to display list of items
    let tableView = UITableView()
    
    // Keeps track of the number of visible cells currently on screen
    var visibleCellCount = 0
    
    // Array holding data to display in the table view
    var dataArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up and configure the table view
        setupTableView()
        
        // Add Auto Layout constraints to the table view
        tableViewConstraints()
        
        // Register custom cell for reuse
        registerCell()
        
        // Load initial data for the table view
        loadData()
        
        // Update the navigation title with the initial cell count
        updateCellCountInNavigationTitle()
    }
    
    // MARK: - Table View Setup Methods
    
    // Set up the table view and add it as a subview
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Add constraints to the table view for full-screen layout
    func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Register the custom table view cell for reuse
    func registerCell() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    // Load data into the table view asynchronously
    func loadData() {
        // Simulate a data loading process on a background thread
        DispatchQueue.global(qos: .background).async {
            let newData = (1...100).map { "Row \($0)" }
            
            // Update UI on the main thread after data is loaded
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.dataArray = newData
                self.tableView.reloadData()
            }
        }
        
    }
    
    // Update the navigation title with the number of visible cells
    func updateCellCountInNavigationTitle() {
        title = "Visible Cells: \(visibleCellCount)"
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate Conformance
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Returns the number of rows in the section (based on data array count)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // Configures and returns the cell for a specific row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.label.text = dataArray[indexPath.row]
        return cell
    }
    
    // Called when a cell is about to be displayed on the screen
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        visibleCellCount += 1
        print("Will display cell at row: \(indexPath.row)")
        
        // Update the navigation title to reflect the new count of visible cells
        updateCellCountInNavigationTitle()
    }
    
    // Called when a cell is no longer visible on the screen
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if visibleCellCount > 0 {
            visibleCellCount -= 1
        }
        
        print("Did end displaying cell at row: \(indexPath.row)")
        
        // Update the navigation title to reflect the new count of visible cells
        updateCellCountInNavigationTitle()
    }
}

