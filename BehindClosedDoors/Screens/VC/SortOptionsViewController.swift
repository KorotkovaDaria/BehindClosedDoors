//
//  SortOptionsViewController.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit

protocol SortOptionsViewControllerDelegate: AnyObject {
    func sortParameter(by option: String, condition: String)
}

class SortOptionsViewController: UIViewController {
    // MARK: - Properties
    weak var delegate: SortOptionsViewControllerDelegate?
    let tableView = UITableView()
    var selectedSortOption: String?
    var selectedSortConditionOption: String?
    
    let sortByText = [
        (Resources.Sort.byDefault, Resources.Condition.sortDef),
        (Resources.Sort.byRooms, Resources.Condition.sortLtoS),
        (Resources.Sort.byRooms, Resources.Condition.sortStoL),
        (Resources.Sort.byDistance, Resources.Condition.sortLtoS),
        (Resources.Sort.byDistance, Resources.Condition.sortStoL)
    ]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    // MARK: - Configuration
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = Resources.Colors.red
        tableView.alpha = 0.7
        tableView.frame = view.bounds
        tableView.rowHeight = 50
        tableView.layer.cornerRadius = 10
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = Resources.Colors.red?.cgColor
        tableView.isScrollEnabled = false

        tableView.register(SortViewCell.self, forCellReuseIdentifier: SortViewCell.reiseID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            tableView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configureViewController() {
        view.backgroundColor = Resources.Colors.pink
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        closeButton.tintColor = Resources.Colors.red
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        doneButton.tintColor = UIColor.black
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Actions
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func doneButton() {
        guard let selectedOption = selectedSortOption, let selectedOptionCondition = selectedSortConditionOption else { return }
        delegate?.sortParameter(by: selectedOption, condition: selectedOptionCondition)
        dismiss(animated: true)
    }
}
    // MARK: - Extension
extension SortOptionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortByText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortViewCell.reiseID) as! SortViewCell
        let sortText = sortByText[indexPath.row].0
        let conditionText = sortByText[indexPath.row].1
        cell.backgroundColor = Resources.Colors.red?.withAlphaComponent(0.7)
        cell.selectionStyle = .none
        cell.titleSortLabel.text = sortText
        cell.subtitleLabel.text = conditionText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedSortOption = sortByText[indexPath.row].0
        selectedSortConditionOption = sortByText[indexPath.row].1
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
