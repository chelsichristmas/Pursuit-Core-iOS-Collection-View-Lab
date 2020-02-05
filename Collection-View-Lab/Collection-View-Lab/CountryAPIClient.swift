//
//  CountryAPIClient.swift
//  Collection-View-Lab
//
//  Created by Chelsi Christmas on 1/18/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryAPIClient {
    
    static func retrieveCountryInfo(for searchQuery: String, completion: @escaping (Result<[Country], AppError>) -> ()) {
        
        
        let countryURLString = "https://restcountries.eu/rest/v2/name/\(searchQuery)"
        
        guard let url = URL(string: countryURLString) else {
            completion(.failure(.badURL(countryURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let countryInfo = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countryInfo))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    

}
