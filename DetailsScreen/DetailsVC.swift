import UIKit

protocol makeFavFromDetailDelegate: AnyObject {
    func addPlanetInFavourites(name: String)
}

class DetailsVC: UIViewController {
    weak var delegate: makeFavFromDetailDelegate?
    private let navStack = UIStackView()
    private let detailImg = UIImageView()
    private let infoStack = UIStackView()
    private var screenTitle = UILabel()
    private let backButton = UIButton()
    private let favButton = UIButton()
    private var isIconActive = false
    private let planet: Planet
    private let isSmallScreen = UIScreen.main.bounds.height < 800 ? true : false
        
    init(_ planet: Planet, index: Int, isIconActive: Bool = false) {
        self.planet = planet
        self.isIconActive = planet.isFaved
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hue: 18/360, saturation: 0.88, brightness: 0.13, alpha: 1)
        view.isUserInteractionEnabled = true
        setupNavigationBar()
        setupDetailsImage()
        setupInfoView()
    }
    
    private func setupNavigationBar() {
        view.addSubview(navStack)
        
        navStack.axis = .horizontal
        navStack.distribution = .equalSpacing
        navStack.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        navStack.isLayoutMarginsRelativeArrangement = true
        
        navStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            navStack.leftAnchor.constraint(equalTo: view.leftAnchor),
            navStack.rightAnchor.constraint(equalTo: view.rightAnchor),
            navStack.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        setupBackButton()
        setupDetailScreenTitle()
        setupFavIcon()
    }
    
    private func setupBackButton() {
        navStack.addArrangedSubview(backButton)
        
        backButton.setImage(UIImage(named: "backIcon"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.addAction(UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupFavIcon() {
        navStack.addArrangedSubview(favButton)
        
        favButton.configureButtonIcon(with: planet.isFaved ? "starActive" : "starInactive", size: 25)
        
        favButton.addAction(UIAction(handler: { action in
            self.updateFavButtonIcon()
            self.updatePlanetStatus()
        }), for: .touchUpInside)
    }
    
    private func setupDetailScreenTitle() {
        navStack.addArrangedSubview(screenTitle)
        screenTitle.configureCustomLabel(with: planet.name, size: 36)
        
        NSLayoutConstraint.activate([
            screenTitle.centerXAnchor.constraint(equalTo: navStack.centerXAnchor),
            screenTitle.centerYAnchor.constraint(equalTo: navStack.centerYAnchor)
        ])
    }
    
    private func setupDetailsImage() {
        view.addSubview(detailImg)
        
        detailImg.image = UIImage(named: planet.image)
        detailImg.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailImg.topAnchor.constraint(equalTo: navStack.bottomAnchor, constant: isSmallScreen ? 76 : 86),
            detailImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailImg.widthAnchor.constraint(equalToConstant: isSmallScreen ? 200 : 280),
            detailImg.heightAnchor.constraint(equalToConstant: isSmallScreen ? 200 : 280)
        ])
    }
    
    private func updatePlanetStatus() {
        self.delegate?.addPlanetInFavourites(name: planet.name)
    }
    
    private func updateFavButtonIcon() {
        isIconActive.toggle()
        favButton.setImage(UIImage(named: isIconActive ? "starActive" : "starInactive"), for: .normal)
    }
}

extension DetailsVC {
    private func setupInfoView() {
        view.addSubview(infoStack)
        
        infoStack.axis = .vertical
        infoStack.spacing = 15
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: detailImg.bottomAnchor, constant: isSmallScreen ? 76 : 112),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let planetInfoArray = [
            ("Area", planet.area),
            ("Temperature", planet.temp),
            ("Mass", planet.mass)
        ]
        
        for prop in planetInfoArray {
            configurePlanetParams(name: prop.0, labelText: prop.1)
        }
    }
    
    private func configurePlanetParams(name: String, labelText: String) {
        let viewStack = UIStackView()
        infoStack.addArrangedSubview(viewStack)
        
        viewStack.axis = .horizontal
        viewStack.spacing = 10
        viewStack.clipsToBounds = true
        viewStack.layer.borderWidth = 1
        viewStack.layer.borderColor = UIColor.white.cgColor
        viewStack.layer.cornerRadius = 15
        viewStack.layoutMargins = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        viewStack.isLayoutMarginsRelativeArrangement = true
        
        let propName = UILabel()
        propName.configureCustomLabel(with: name, size: 18)
        viewStack.addArrangedSubview(propName)
        
        let propValue = UILabel()
        propValue.configureCustomLabel(with: labelText, size: 18)
        viewStack.addArrangedSubview(propValue)
        
        NSLayoutConstraint.activate([
            viewStack.leadingAnchor.constraint(equalTo: infoStack.leadingAnchor, constant: 0),
            viewStack.trailingAnchor.constraint(equalTo: infoStack.trailingAnchor, constant: 0),
        ])
    }
}
