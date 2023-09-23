//
//  ViewController.swift
//  Example
//
//  Created by João Lucas on 23/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "photo")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photo)
        
        photo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 300).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        view.backgroundColor = .white
    }

}
