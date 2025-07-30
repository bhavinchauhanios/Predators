//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Bhavin Chauhan on 30/07/25.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators() // Assuming this is a model providing `apexPredators`
    
    @State var position: MapCameraPosition
    @State var satelite = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(height:100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x:-1)
                }
            }
        }
        
        .mapStyle(.imagery(elevation: .realistic))
        .overlay(alignment: .bottomTrailing){
            Button{
                satelite.toggle()
            }label: {
                Image(systemName: satelite ? "globe.amrices.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location,
                                            distance: 1000,
                                           heading: 250,
                                           pitch: 80)))
    .preferredColorScheme(.dark)
}
