//
//  TableViewProgrammaticallySession2Tests.swift
//  TableViewProgrammaticallySession2Tests
//
//  Created by Matthew Dolan on 2024-11-29.
//

import XCTest
@testable import TableViewProgrammaticallySession2

final class TableViewProgrammaticallySession2Tests: XCTestCase {

    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        // Initialize the view controller instance before each test
        viewController = ViewController()
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Cleanup after  each test
        viewController = nil
        super.tearDown()
    }
    
    // Test to verify data is loaded properly
    func testLoadData() {
        viewController.loadData()
        
        // Using expectations to wait for the async call to complete
        let expectation = self.expectation(description: "Data Loaded")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewController.dataArray.count, 100, "Data array should contain 100 items")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    // Test to verify number of rows matches the data array count
    func testNumberOfRowsInTableView() {
        viewController.loadData()
        
        let expectation = self.expectation(description: "Number of rows is correct")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let numberOfRows = self.viewController.tableView(self.viewController.tableView, numberOfRowsInSection: 0)
            
            XCTAssertEqual(numberOfRows, 100, "TableView should have 100 rows")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    // Test to verify visible cell count update
    func testVisibleCellCount() {
        viewController.loadData()
        
        // Wait for async loading to complete
        let expectation = self.expectation(description: "Visible cell count updated correctly")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewController.tableView.reloadData()
            
            // Simulate willDisplay for first few cells
            let indexPath = IndexPath(row: 0, section: 0)
            self.viewController.tableView(self.viewController.tableView, willDisplay: CustomTableViewCell(), forRowAt: indexPath)
            
            XCTAssertEqual(self.viewController.visibleCellCount, 1, "Visible cell count should be 1 after displaying one cell")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
