//
//  File.swift
//  BehindClosedDoors
//
//  Created by Daria on 14.05.2024.
//

import Foundation
import UIKit

extension MainViewController: MainViewModelDelegate {
    func showLoadingIndicator() {
        showLoadingView()
    }
    
    func dismissLoadingIndicator() {
        dismissLoadingView()
    }
    
    func showListHotels() {
        tableView.reloadData()
    }
    
    func showFetchError(error: String) {
        presentAlertOnMainTread(title: Resources.AlertText.titleWrongAlert,
                                message: error,
                                buttonTitle: Resources.AlertText.okButtonTitleAlert)
    }
    
    func sortParameter(by option: String, condition: String) {
        model.sortedHotels(by: option, condition: condition)
        tableView.reloadData()
    }
    
}
