//
//  GlobalExtensions.swift
//  17. UiCollectionView
//
//  Created by Despo on 19.10.24.
//
import UIKit

extension UILabel {
    func configureCustomLabel(with title: String, size: CGFloat) {
        self.font = UIFont.boldSystemFont(ofSize: size)
        self.textColor = UIColor.white
        self.text = title
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton {
    func configureButtonIcon(with icon: String, size: CGFloat) {
        self.setImage(UIImage(named: icon), for: .normal)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.imageView?.widthAnchor.constraint(equalToConstant: size) ?? NSLayoutConstraint(),
            self.imageView?.heightAnchor.constraint(equalToConstant: size) ?? NSLayoutConstraint()
        ])
    }
}
