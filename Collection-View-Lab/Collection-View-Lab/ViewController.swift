 //
//  ViewController.swift
//  Collection-View-Lab
//
//  Created by Chelsi Christmas on 1/18/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchQuery = ""

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var countryInfo = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
    }
    
    func searchCountry(searchQuery: String) {
        CountryAPIClient.retrieveCountryInfo(for: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
               print("\(appError)")
            case .success(let countryInfoData):
                self.countryInfo = countryInfoData
            }
        }
    }


}
 extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("UNABLE TO DEQEUE COUNTRY CELL")
        }
        
        let country = countryInfo[indexPath.row]
        cell.configureCell(country: country)
        
        
    return cell
    }
    
 }
 
 extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//         let interItemSpacing: CGFloat = 10 // space between items
           let maxWidth = UIScreen.main.bounds.size.width // device's width
        let maxHeight = UIScreen.main.bounds.size.width
        let cellWidth = CGFloat(maxWidth * 0.8)
        let cellHeight = CGFloat(maxHeight * 0.4)
           
           return CGSize(width: cellWidth, height: cellHeight)
    }
    
 }
 
 extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        
        searchCountry(searchQuery: searchText)
    }
 }

