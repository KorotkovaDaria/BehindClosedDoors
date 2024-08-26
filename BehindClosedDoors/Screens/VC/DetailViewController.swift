//
//  DetailViewController.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    // MARK: - Properties
    let model = DetailViewModel()
    
    var mapView: MKMapView!
    var mainImage = BCDImageView(frame: .zero)
    var starImage = UIImageView()
    var nameLabel = BCDTitleLabel(textAlignment: .left, color: .white)
    var addressLabel = BCDBodyLabel(textAlignment: .left, color: .white)
    var roomsLabel = BCDBodyLabel(textAlignment: .left, color: .white)
    var distanceLabel = BCDBodyLabel(textAlignment: .left, color: .white)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.mainController = self
        model.fetchItemHotel()
        
        configureViewController()
    }
    // MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = Resources.Colors.red
        
        let sortedButton = UIBarButtonItem(image: Resources.ImageTitle.arrowUpBackward,
                                           style: .plain,
                                           target: self,
                                           action: #selector(dismissVC))
        sortedButton.tintColor = UIColor.black
        
        navigationItem.leftBarButtonItem = sortedButton
    }
    // MARK: - Add func
    func addViews() {
            self.addMapView()
            self.addMainImage()
            self.addNameLabel()
            self.addStarImage()
            self.addAddressLabel()
            self.addDistanceLabel()
            self.addNumberOfAvailableLabel()
    }
    
    func addMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        if let selectedHotel = model.selectedHotel {
            let initialLocation = CLLocation(latitude: selectedHotel.lat, longitude: selectedHotel.lon)
            let regionRadius: CLLocationDistance = 5000
            let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: selectedHotel.lat, longitude: selectedHotel.lon)
            annotation.title = selectedHotel.name
            annotation.subtitle = selectedHotel.address
            mapView.addAnnotation(annotation)
            
        }
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func addMainImage() {
        view.addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let selectedHotel = model.selectedHotel, let selectedImage = selectedHotel.image {
            let activityIndicator = addLoadingImage(to: mainImage)
            model.networkManager.downloadImage(from: selectedImage) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    if let newImage = image {
                        let croppedImage = newImage.croppedImage(withInsets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
                        self.mainImage.image = croppedImage
                    }
                }
            }
        }
        
        NSLayoutConstraint.activate([
            mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            mainImage.widthAnchor.constraint(equalToConstant: 350),
            mainImage.heightAnchor.constraint(equalToConstant: 195)
        ])
    }

    func addNameLabel() {
        view.addSubview(nameLabel)
        
        if let selectedHotel = model.selectedHotel {
            nameLabel.text = selectedHotel.name
        }
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            
        ])
    }
    
    func addStarImage() {
        view.addSubview(starImage)
        if let selectedHotel = model.selectedHotel {
            let counrStar = selectedHotel.stars
            switch counrStar {
            case 0:
                starImage.image = Resources.ImageTitle.zeroStar
            case 1:
                starImage.image = Resources.ImageTitle.oneStar
            case 2:
                starImage.image = Resources.ImageTitle.twoStar
            case 3:
                starImage.image = Resources.ImageTitle.threeStar
            case 4:
                starImage.image = Resources.ImageTitle.fourStar
            case 5:
                starImage.image = Resources.ImageTitle.fiveStar
            default:
                break
            }
        }
        
        starImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            starImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            starImage.heightAnchor.constraint(equalToConstant: 29),
            starImage.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func addAddressLabel() {
        view.addSubview(addressLabel)
        
        if let selectedHotel = model.selectedHotel {
            addressLabel.text = selectedHotel.address
        }
        
        addressLabel.font = UIFont.systemFont(ofSize: 15)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: starImage.bottomAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func addDistanceLabel() {
        view.addSubview(distanceLabel)
        
        if let selectedHotel = model.selectedHotel {
            distanceLabel.text = "Distance to city center: \(Int(selectedHotel.distance)) meters"
        }
        
        distanceLabel.font = UIFont.systemFont(ofSize: 15)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func addNumberOfAvailableLabel() {
        view.addSubview(roomsLabel)
        
        roomsLabel.font = UIFont.systemFont(ofSize: 15)
        roomsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let selectedHotel = model.selectedHotel {
            let countRooms = selectedHotel.suitesAvailability.extractAvailableSuitesCount().count
            roomsLabel.text = "Number of available rooms: \(countRooms)"
        }
        
        NSLayoutConstraint.activate([
            roomsLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 4),
            roomsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            roomsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    // MARK: - Actions
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
