//
//  MainViewController.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate, SortOptionsViewControllerDelegate {
    // MARK: - Properties
    let model = MainViewModel()
    let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        
        model.delegate = self
        model.mainController = self
        model.fetchListHotels()
    }
    
    // MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = Resources.Colors.pink
        
        let sortedButton = UIBarButtonItem(image: Resources.ImageTitle.arrowSorted, style: .plain, target: self, action: #selector(listSorted))
        sortedButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = sortedButton
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = Resources.Colors.red
        tableView.alpha = 0.7
        tableView.layer.cornerRadius = 10
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.register(ListHotelsCell.self, forCellReuseIdentifier: ListHotelsCell.reiseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding/2),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding/2),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // MARK: - Actions
    @objc func listSorted() {
        let sortOptionsVC = SortOptionsViewController()
        sortOptionsVC.delegate = self
        let navController = UINavigationController(rootViewController: sortOptionsVC)
        navController.modalPresentationStyle = .overFullScreen
        sortOptionsVC.title = "SORT BY"
        present(navController, animated: true, completion: nil)
    }
}
    // MARK: - Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.isSorted ? model.sortedHotels.count : model.listHotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListHotelsCell.reiseID) as! ListHotelsCell
        cell.backgroundColor = Resources.Colors.red
        cell.alpha = 0.7
        cell.selectionStyle = .none
        let activeArray = model.isSorted ? model.sortedHotels : model.listHotels
        let listHotels = activeArray[indexPath.row]
        cell.set(listHotel: listHotels)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHotel = model.isSorted ? model.sortedHotels[indexPath.row] : model.listHotels[indexPath.row]
        let destVC = DetailViewController()
        destVC.title = selectedHotel.name
        destVC.model.idHotel = selectedHotel.id
        let navController = UINavigationController(rootViewController: destVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
