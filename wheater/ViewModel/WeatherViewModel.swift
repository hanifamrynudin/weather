//
//  WeatherManager.swift
//  wheater
//
//  Created by Hanif Fadillah Amrynudin on 01/09/22.
//

import Foundation
import CoreLocation

class WeatherViewModel : ObservableObject {
    
    @Published var weather = [WeatherModel]()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a1faa9b0d55de0551810719a5bca6491&units=metric"
    
    func fetchWeather(CityName: String) {
        let urlString = "\(weatherURL)&q=\(CityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    
//    func fetchData() {
//        if let url = URL(string: urlFinal) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error == nil {
//                    let decoder = JSONDecoder()
//                    if let safeData = data {
//                        do {
//                            let decodedData = try decoder.decode(WeatherData.self, from: safeData)
//                            DispatchQueue.main.async {
//                                let name = decodedData.name
//
//                                let weather = WeatherModel(nameCity: name)
//                                print(name)
//                            }
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        DispatchQueue.main.async {
            
            if let url = URL(string: urlString) {

                //2. Create a URLSession
                let session = URLSession(configuration: .default)

                //3. Give the session a task
                let task = session.dataTask(with: url, completionHandler: self.handle(data:response:err:))
                
                    // 4. Start the task
                task.resume()
            }
        }
    }

    func handle(data: Data?, response: URLResponse?, err: Error?) {
        if err != nil {
            print(err)
            return
        }

        if let safeData = data {
            parseJSON(safeData)
            print("in")
        }
    }

    func parseJSON(_ wheaterData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {

            let decodedData = try decoder.decode(WeatherData.self, from: wheaterData)

            let name = decodedData.name

            let weather = WeatherModel(nameCity: name)
            weather.printCity()
            print(name)
            return weather

        } catch {
            print(error)
            return nil
        }
    }
}