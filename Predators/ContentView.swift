//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Bhavin Chauhan on 29/07/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = APType.all
    
    var filteredDinos : [ApexPredators] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        
        NavigationStack{
            List(filteredDinos) { predators in
                NavigationLink{
                    PedatorDetail(prediaotor: predators, position: .camera(MapCamera(centerCoordinate: predators.location, distance: 300000)))
                }label: {
                    
                    HStack{
                        
                        //Dinosaur image
                        Image(predators.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStackLayout(alignment: .leading){
                            //Name
                            Text(predators.name)
                                .fontWeight(.bold)
                            
                            //Type
                            Text(predators.type.rawValue.capitalized)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predators.type.background)
                                .clipShape(.capsule)
                            
                        }
                    }
                }
            }
            
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }

                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("Filter", selection: $currentSelection){
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
