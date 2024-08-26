//
//  DetailViewController+showHotel.swift
//  BehindClosedDoors
//
//  Created by Daria on 14.05.2024.
//

import Foundation

extension DetailViewController: DetailViewModelDelegate {
    func showLoadingIndicator() {
        showLoadingView()
    }
    
    func dismissLoadingIndicator() {
        dismissLoadingView()
    }
    
    func showHotel() {
        DispatchQueue.main.async {
            self.addViews()
        }
    }
    
    func showFetchError(error: String) {
        presentAlertOnMainTread(title: Resources.AlertText.titleWrongAlert,
                                message: error,
                                buttonTitle: Resources.AlertText.okButtonTitleAlert)
    }
}
