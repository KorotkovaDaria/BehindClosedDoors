//
//  MainModelView.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit
    // MARK: - Protocol
protocol MainViewModelDelegate: AnyObject {
    func showListHotels()
    func showFetchError(error: String)
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

class MainViewModel {
    // MARK: - Properties
    weak var delegate: MainViewModelDelegate?
    weak var mainController: UIViewController?
    let networkManager = NetworkManager.shared
    var listHotels: [ListHotels] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.showListHotels()
            }
        }
    }
    var sortedHotels: [ListHotels] = []
    var isSorted = false
    
    // MARK: - Network
    func fetchListHotels() {
        self.delegate?.showLoadingIndicator()
        networkManager.getListHotels { [weak self] result in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            switch result {
            case .success(let hotels):
                self.listHotels = hotels
                self.sortedHotels = hotels
            case .failure(let error):
                self.delegate?.showFetchError(error: error.rawValue)
            }
        }
    }
    // MARK: - Sort func
    func sortedHotels(by option: String, condition: String) {
        switch option {
        case Resources.Sort.byDefault:
            sortedHotels = listHotels
        case Resources.Sort.byRooms:
            if condition == Resources.Condition.sortLtoS {
                sortedHotels = listHotels.sorted { $0.suitesAvailability.extractAvailableSuitesCount().count > $1.suitesAvailability.extractAvailableSuitesCount().count }
            } else {
                sortedHotels = listHotels.sorted { $0.suitesAvailability.extractAvailableSuitesCount().count < $1.suitesAvailability.extractAvailableSuitesCount().count }
            }
            isSorted = true
        case Resources.Sort.byDistance:
            if condition == Resources.Condition.sortLtoS {
                sortedHotels = listHotels.sorted { $0.distance > $1.distance }
            } else {
                sortedHotels = listHotels.sorted { $0.distance < $1.distance }
            }
            isSorted = true
        default:
            break
        }
    }
}
