//
//  CountryCell.swift
//  Collection-View-Lab
//
//  Created by Chelsi Christmas on 1/18/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import UIKit
import ImageKit

class CountryCell: UICollectionViewCell {
    
    //    var country: Country!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryFlagImage: UIImageView!
    
    @IBOutlet weak var capitalLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    func configureCell(country: Country) {
        countryLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital)"
        populationLabel.text = "Population: \(country.population)"
        
        countryFlagImage.getImage(with: country.capital) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.countryFlagImage.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                self?.countryFlagImage.image = image
                }
            }
            
        }

    }
}


