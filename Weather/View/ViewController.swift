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
    @IBOutlet weak var conditionWeatherLabel: UILabel!
    @IBOutlet weak var timeWeatherLabel: UILabel!
    @IBOutlet weak var conditionWeatherImgView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditionWeatherImgView.isHidden = true
        
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
                    self.tempLabel.text = "\(Int(weatherData.current.tempC))°"
                    self.conditionWeatherLabel.text = weatherData.current.condition.text
                    self.timeWeatherLabel.text = "Now"
                    self.conditionWeatherImgView.image = UIImage(named: "\(weatherData.current.condition.icon.replacingOccurrences(of: "/", with: ""))")
                    self.windLabel.text = "Wind"
                    self.windResultLabel.text = "\(weatherData.current.windKph)m/s"
                    
                    
                    self.tempLabel.isHidden = false
                    self.conditionWeatherLabel.isHidden = false
                    self.timeWeatherLabel.isHidden = false
                    self.conditionWeatherImgView.isHidden = false
                    self.windLabel.isHidden = false
                    self.windResultLabel.isHidden = false
                    
                }
                
            case .failure(let error):
                print("error: \(error)")
                DispatchQueue.main.async {
                    self.cityNameLabel.text = "No matching location found."
                    self.tempLabel.isHidden = true
                    self.conditionWeatherLabel.isHidden = true
                    self.timeWeatherLabel.isHidden = true
                    self.conditionWeatherImgView.isHidden = true
                    self.windLabel.isHidden = true
                    self.windResultLabel.isHidden = true
                }
            }
        })
    }
}
