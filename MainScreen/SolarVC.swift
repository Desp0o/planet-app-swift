//
//  ViewController.swift
//  17. UiCollectionView
//
//  Created by Despo on 19.10.24.
//

import UIKit

class SolarVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private let collectionView: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: 168, height: 180)
        collectionLayout.minimumLineSpacing = 38
        
        collection = UICollectionView(frame: CGRect(x: 20, y: 20, width: 100, height: 100), collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()

    private var screenTitleLbl = UILabel()
    private let vectors = UIImageView()
    
    var planetsArray = [
        Planet(image: "mercury", name: "Mercury", area: "1,258,250 km²", temp: "-60°C", mass: "460.234.317", isFaved: false),
        Planet(image: "venus", name: "Venus", area: "4,602,000 km²", temp: "462°C", mass: "4.867×10^24 kg", isFaved: false),
        Planet(image: "earth", name: "Earth", area: "510,100,000 km²", temp: "15°C", mass: "5.972×10^24 kg", isFaved: false),
        Planet(image: "mars", name: "Mars", area: "144,800,000 km²", temp: "-63°C", mass: "641.71×10^21 kg", isFaved: false),
        Planet(image: "jupiter", name: "Jupiter", area: "61,418,738,571 km²", temp: "-145°C", mass: "1.898×10^27 kg", isFaved: false),
        Planet(image: "uranus", name: "Uranus", area: "8,115,600,000 km²", temp: "-224°C", mass: "8.681×10^25 kg", isFaved: false),
        Planet(image: "neptune", name: "Neptune", area: "7,618,300,000 km²", temp: "-214°C", mass: "1.024×10^26 kg", isFaved: false),
        Planet(image: "pluto", name: "Pluto", area: "16,647,940 km²", temp: "-229°C", mass: "1.303×10^22 kg", isFaved: false),
        Planet(image: "eris", name: "Eris", area: "6,440,000 km²", temp: "-243°C", mass: "1.66×10^22 kg", isFaved: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(hue: 18/360, saturation: 0.88, brightness: 0.13, alpha: 1)

        view.addSubview(collectionView)
    
        setupScreenTitle()
        setupCollectionView()
    }
    
    private func setupScreenTitle() {
        view.addSubview(screenTitleLbl)
        screenTitleLbl.configureCustomLabel(with: "Planets", size:  36)
        
        NSLayoutConstraint.activate([
            screenTitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            screenTitleLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(PlanetCell.self, forCellWithReuseIdentifier: "PlanetCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: screenTitleLbl.bottomAnchor, constant: 56),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44)
        ])
    }
}

extension SolarVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planetsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as? PlanetCell
        
        let currentPlanet = planetsArray[indexPath.row]
        
        cell?.isUserInteractionEnabled = true
        cell?.delegate = self
        cell?.configurePlanetCell(planet: currentPlanet, index: indexPath.row)
        
        return cell ?? PlanetCell()
    }
}

extension SolarVC: makeFavFromCellDelegate {
    func savePlanet(index: Int) {
        
        
        planetsArray[index].isFaved.toggle()
        
        let currentPlanet = planetsArray.remove(at: index)
        
        if currentPlanet.isFaved {
            planetsArray.insert(currentPlanet, at: 0)
        } else {
            planetsArray.append(currentPlanet)
        }
        
        collectionView.reloadData()
    }
}

extension SolarVC: makeFavFromDetailDelegate {
    func addPlanetInFavourites(name: String) {
        let currentPlanet = planetsArray.first { planet in
            planet.name == name
        }
         
        guard var currentPlanet = currentPlanet else { return }
        
        currentPlanet.isFaved.toggle()
        
        let index = planetsArray.firstIndex { name in
            name.name == currentPlanet.name
        }
        
        planetsArray.remove(at: index ?? 0)

        if currentPlanet.isFaved  {
            planetsArray.insert(currentPlanet, at: 0)
        } else {
            planetsArray.append(currentPlanet)
        }
     
        collectionView.reloadData()        
    }
}

extension SolarVC {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPlanet = planetsArray[indexPath.row]
        
        let detailsVC = DetailsVC(currentPlanet, index: indexPath.item)
        detailsVC.delegate = self
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}



//
//#Preview {
//    let vc = SolarVC()
//    return vc
//}
