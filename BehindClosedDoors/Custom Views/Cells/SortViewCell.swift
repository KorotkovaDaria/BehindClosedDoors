//
//  SortViewCell.swift
//  BehindClosedDoors
//
//  Created by Daria on 12.05.2024.
//

import UIKit

class SortViewCell: UITableViewCell {
    // MARK: - Properties
    static let reiseID  = "SortViewCell"
    let titleSortLabel = BCDTitleLabel(textAlignment: .left, color: UIColor.white)
    let subtitleLabel = BCDBodyLabel(textAlignment: .left, color: UIColor.white)
    let selectionIndicator = UIImageView()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Configuration
    private func configure() {
        contentView.addSubview(titleSortLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(selectionIndicator)
        
        selectionIndicator.image = UIImage(named: "checkmark")
        
        titleSortLabel.font = UIFont.boldSystemFont(ofSize: 15)
        subtitleLabel.font = UIFont.systemFont(ofSize: 10)
        
        titleSortLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        
        titleSortLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleSortLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleSortLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleSortLabel.widthAnchor.constraint(equalToConstant: 300),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleSortLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 300),
            
            selectionIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectionIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            selectionIndicator.widthAnchor.constraint(equalToConstant: 30),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionIndicator.isHidden = !selected
    }
}
