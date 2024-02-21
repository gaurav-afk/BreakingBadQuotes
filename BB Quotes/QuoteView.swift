//
//  QuoteView.swift
//  BB Quotes
//
//  Created by Gaurav Rawat on 2024-02-20.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    @State private var showCharacterInfo: Bool = false
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            
            ZStack{
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    VStack{
                        Spacer(minLength: 150)
                        
                        switch viewModel.status {
                            
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .minimumScaleFactor(0.6)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            ZStack(alignment: .bottom){
                                AsyncImage(url: data.character.images[0]){ image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                                .sheet(isPresented: $showCharacterInfo, content: {
                                    CharacterView(show: show, character: data.character)
                                })
                                
                                Text(data.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .cornerRadius(80)
                            
                            
                        case .fetching:
                            ProgressView()
                            
                        case .failed(let error):
                            HStack{
                                Image(systemName: "wrongwaysign.fill")
                                    .foregroundColor(.red)
                                Text(error.localizedDescription)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .padding(.horizontal)
                            
                        default:
                            ProgressView()
                        }
                        
                        Spacer()
                        
                        Button{
                            Task{ await viewModel.getData(for: show) }
                        }label: {
                            Text("Get Random Quote")
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.noSpaces)Button"))
                                .cornerRadius(10)
                                .shadow(color: Color("\(show.noSpaces)Shadow"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        Spacer(minLength: 200)
                    }
                    .frame(width: geo.size.width)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear{
            Task{ await viewModel.getData(for: show) }
        }
    }
        
}


#Preview {
    QuoteView(show: Constants.bcsName)
        .preferredColorScheme(.dark)
}
