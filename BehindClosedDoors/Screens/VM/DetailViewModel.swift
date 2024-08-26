//
//  DetailViewModel.swift
//  BehindClosedDoors
//
//  Created by Daria on 14.05.2024.
//

import Foundation
import UIKit

protocol DetailViewModelDelegate: AnyObject {
    func showHotel()
    func showFetchError(error: String)
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

class DetailViewModel {
    // MARK: - Properties
    weak var delegate: DetailViewModelDelegate?
    weak var mainController: UIViewController?
    let networkManager = NetworkManager.shared
    var selectedHotel: InfoAboutHotel!
    var idHotel: Int!
    
    // MARK: - Network
    func fetchItemHotel() {
        delegate?.showLoadingIndicator()
        networkManager.getInfoHotel(hotel: idHotel) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            switch result {
            case .success(let hotel):
                self.selectedHotel = hotel
                DispatchQueue.main.async {
                    self.delegate?.showHotel()
                }
            case .failure(let error):
                self.delegate?.showFetchError(error: error.rawValue)
            }
        }
    }
}
