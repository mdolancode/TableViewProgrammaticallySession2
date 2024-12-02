//
//  CustomTableViewCell.swift
//  TableViewProgrammaticallySession2
//
//  Created by Matthew Dolan on 2024-11-28.
//

import UIKit

// CustomTableViewCell is a UITableViewCell subclass that contains a single UILabel for displaying text.
final class CustomTableViewCell: UITableViewCell {
    
    // UILabel instance for displaying the cell's content.
    let label = UILabel()
    
    // Static identifier to reuse cells, improving performance.
    static let identifier = "CustomTableViewCell"
    
    // Override the default initializer to set up the label when creating a cell programmatically.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel() // Configure the label properties and constraints.
    }
    
    // Required initializer for decoding cells from Interface Builder.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Called when the cell is reused. Reset the label to prevent display issues.
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
    }
    
    // Set up the label by adding it to the content view and configuring its layout.
    private func setupLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        
        // Set up Auto Layout constraints to position the label within the content view.
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
    }
}
