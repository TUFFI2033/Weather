//
//  ViewController.swift
//  Weather
//
//  Created by Ivan Byndiu on 26/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
        
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let searchText = searchBar.text {
            weatherRes(cityName: searchText)
        }
        
        searchBar.text = ""
    }
    
    func weatherRes(cityName: String?) {
        NetworkService.shared.fetchData(cityName: cityName ?? "", completion: { response in
            switch response {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.cityNameLabel.text = weatherData.location.country + ", " + weatherData.location.name
                    self.tempLabel.text = "\(weatherData.current.tempC)°C"
                    self.tempLabel.isHidden = false
                }
            case .failure(let error):
                print("error: \(error)")
                DispatchQueue.main.async {
                    self.cityNameLabel.text = "No matching location found."
                    self.tempLabel.isHidden = true
                }
            }
        })
    }
}
