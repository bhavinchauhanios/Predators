//
//  PedatorDetail.swift
//  JPApexPredators
//
//  Created by Bhavin Chauhan on 30/07/25.
//

import SwiftUI
import MapKit

struct PedatorDetail: View {
    
    let prediaotor : ApexPredators
    
    @State var position : MapCameraPosition
    @Namespace var namesapce
    
    var body: some View {
        
        GeometryReader{ geo in
            ScrollView{
                
                ZStack(alignment: .bottomTrailing){
                    
                    // Background Image
                    Image(prediaotor.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops:
                                            [Gradient.Stop(color: .clear, location: 0.8),
                                                   Gradient.Stop(color: .black, location: 1)],
                                           startPoint: .top, endPoint: .bottom)
                        }
                    
                    
                    
                    //Dino Image
                    Image(prediaotor.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 7)
                        .offset(y:20)
                }
                
                VStack(alignment: .leading){
                    
                    // Dino name
                    Text(prediaotor.name)
                    .font(.largeTitle)
                    
                    //Current Location
                    NavigationLink{
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: prediaotor.location,
                                                                distance: 1000,
                                                               heading: 250,
                                                               pitch: 80)))
                        .navigationTransition(.zoom(sourceID: 1, in: namesapce))
                    }label: {
                        Map(position: $position){
                            Annotation(prediaotor.name, coordinate: prediaotor.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                            .frame(height: 125)
                            .clipShape(.rect(cornerRadius: 15))
                            .overlay(alignment: .trailing){
                                Image(systemName: "greaterthan")
                                    .imageScale(.large)
                                    .font(.title3)
                                    .padding(.trailing,5)
                            }
                        
                            .overlay(alignment: .topLeading){
                                Text("Currenct Location")
                                    .padding([.leading, .bottom], 5)
                                    .padding(.trailing,8)
                                    .background(.black.opacity(0.33))
                                    .clipShape(.rect(bottomTrailingRadius: 15))
                            }
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    .matchedTransitionSource(id: 1, in: namesapce)
                    
                    //Appears in
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    
                    ForEach(prediaotor.movies, id: \.self){ movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    //Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(prediaotor.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(prediaotor.link, destination: URL(string: prediaotor.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                    
                    //
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
                
                
                
            }
            
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    
    let predator = Predators().apexPredators[2]
    NavigationStack{
        PedatorDetail(prediaotor: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
    
}
