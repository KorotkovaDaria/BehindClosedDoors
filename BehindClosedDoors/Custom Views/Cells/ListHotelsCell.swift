//
//  ListHotelsCell.swift
//  BehindClosedDoors
//
//  Created by Daria on 08.05.2024.
//

import UIKit

class ListHotelsCell: UITableViewCell {
    // MARK: - Properties
    static let reiseID  = "ListHotelsCell"
    
    let titleHotelLabel = BCDTitleLabel(textAlignment: .left, color: UIColor.white)
    let addressLabel = BCDBodyLabel(textAlignment: .left, color: UIColor.white)
    let distancLabel = BCDBodyLabel(textAlignment: .left, color: UIColor.white)
    let numberOfAvailableLabel = BCDBodyLabel(textAlignment: .left, color: UIColor.white)
    let starImage = UIImageView()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Configuration
    func set(listHotel: ListHotels) {
        let countRooms = listHotel.suitesAvailability.extractAvailableSuitesCount().count
        titleHotelLabel.text = listHotel.name
        addressLabel.text = "Address: \(listHotel.address)"
        distancLabel.text = "Distance to city center: \(Int(listHotel.distance)) meters"
        numberOfAvailableLabel.text = "Number of available rooms: \(countRooms)"
        let counrStar = listHotel.stars
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
    
    private func configure() {
        contentView.addSubview(titleHotelLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(distancLabel)
        contentView.addSubview(numberOfAvailableLabel)
        contentView.addSubview(starImage)
        
        titleHotelLabel.numberOfLines = 0
        addressLabel.numberOfLines = 0
        distancLabel.numberOfLines = 0
        numberOfAvailableLabel.numberOfLines = 0
        
        titleHotelLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        distancLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfAvailableLabel.translatesAutoresizingMaskIntoConstraints = false
        starImage.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleHotelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleHotelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleHotelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            addressLabel.topAnchor.constraint(equalTo: titleHotelLabel.bottomAnchor, constant: padding),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            distancLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: padding),
            distancLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            distancLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),

            numberOfAvailableLabel.topAnchor.constraint(equalTo: distancLabel.bottomAnchor, constant: padding),
            numberOfAvailableLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            numberOfAvailableLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),

            starImage.topAnchor.constraint(equalTo: numberOfAvailableLabel.bottomAnchor, constant: padding),
            starImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            starImage.heightAnchor.constraint(equalToConstant: 29),
            starImage.widthAnchor.constraint(equalToConstant: 130),
            starImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
