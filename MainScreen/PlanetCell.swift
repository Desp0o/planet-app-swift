//
//  PlanetCell.swift
//  17. UiCollectionView
//
//  Created by Despo on 19.10.24.
//

import UIKit

protocol makeFavFromCellDelegate: AnyObject {
    func savePlanet(index: Int)
}

final class PlanetCell: UICollectionViewCell {
    weak var delegate: makeFavFromCellDelegate?
    private let planetImg = UIImageView()
    private let stackView = UIStackView()
    private let planetinfoStack = UIStackView()
    private let favouriteButton = UIButton()
    private let titleLbl = UILabel()
    private let areaLbl = UILabel()
    private var isFaved = false
    private var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupImage()
        setupTitleAndfavouriteButton()
    }
    
    private func setupImage() {
        contentView.addSubview(planetImg)
        planetImg.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            planetImg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            planetImg.widthAnchor.constraint(equalToConstant: 100),
            planetImg.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTitleAndfavouriteButton() {
        contentView.addSubview(planetinfoStack)
        
        planetinfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetinfoStack.topAnchor.constraint(equalTo: planetImg.bottomAnchor, constant: 10),
        ])
        
        setupStack()
    }
    
    private func setupStack() {
        planetinfoStack.addArrangedSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        setupTitleLabel()
        setupFavouriteIcon()
        setupAreaLabel()
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = UIFont.boldSystemFont(ofSize: 32)
        titleLbl.textColor = .white
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0)
        ])
    }
    
    private func setupFavouriteIcon() {
        stackView.addArrangedSubview(favouriteButton)
        stackView.bringSubviewToFront(favouriteButton)
        
        favouriteButton.isUserInteractionEnabled = true
        favouriteButton.configureButtonIcon(with: isFaved ? "starActive" : "starInactive", size: 15)
        
        favouriteButton.addAction(UIAction(handler: { action in
            self.updatePlanetView()
        }), for: .touchUpInside)
    }
    
    private func setupAreaLabel() {
        planetinfoStack.addSubview(areaLbl)
        
        areaLbl.font = UIFont.boldSystemFont(ofSize: 18)
        areaLbl.textColor = UIColor.white
        
        areaLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            areaLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            areaLbl.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8)
        ])
    }
    
    private func updatePlanetView() {
        guard let index = index else { return }
        delegate?.savePlanet(index: index)
    }
    
    func configurePlanetCell(planet: Planet, index: Int) {
        self.planetImg.image = UIImage(named: planet.image)
        self.titleLbl.text = planet.name
        self.areaLbl.text = planet.area
        self.isFaved = planet.isFaved
        self.index = index
        
        favouriteButton.configureButtonIcon(with: isFaved ? "starActive" : "starInactive", size: 15)
    }
}


