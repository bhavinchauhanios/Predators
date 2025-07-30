//
//  Predators.swift
//  JPApexPredators
//
//  Created by Bhavin Chauhan on 29/07/25.
//

import Foundation

class Predators{
    var allApexPredators : [ApexPredators] = []
    var apexPredators : [ApexPredators] = []
    
    init(){
        decodeApexPredatorData()
    }
    
    func  decodeApexPredatorData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredators].self, from: data)
                apexPredators = allApexPredators
            }catch{
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchItem : String) -> [ApexPredators]{
        if searchItem.isEmpty{
            return apexPredators
        }else{
            return apexPredators.filter { prediator in
                prediator.name.localizedStandardContains(searchItem)
            }
        }
    }
    
    func sort(by alphabetical:Bool){
        apexPredators.sort{ predator1, predator2 in
            if alphabetical{
                predator1.name < predator2.name
            }else{
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type : APType){
        if type == .all{
            apexPredators = allApexPredators
        }else{
            apexPredators = allApexPredators.filter { predator in
                return predator.type == type
            }
        }
    }
    
}
