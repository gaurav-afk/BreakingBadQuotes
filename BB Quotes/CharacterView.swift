//
//  CharacterView.swift
//  BB Quotes
//
//  Created by Gaurav Rawat on 2024-02-21.
//

import SwiftUI

struct CharacterView: View {
    
    let show: String
    let character: Character
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .top){
                // background image
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                
                ScrollView{
                    // character image
                    VStack{
                        AsyncImage(url: character.images.randomElement()){ image in
                            image
                                .image?.resizable()
                                .scaledToFill()
                            
                        }
                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .cornerRadius(25)
                    .padding(.top, 60)
                    
                    // character info
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        Divider()
                        
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        Text("Born: \(character.birthday)")
                        Divider()
                        
                        Text("Occupations:")
                        ForEach(character.occupations, id: \.self){ occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        Divider()
                        
                        Text("Nicknames:")
                        if(!character.aliases.isEmpty){
                            ForEach(character.aliases, id: \.self){ aliases in
                                Text("• \(aliases)")
                                    .font(.subheadline)
                            }
                        }else{
                            Text("none")
                        }
                    }
                    .padding([.leading, .bottom], 30)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(show: Constants.bbName, character: Constants.previewCharacter)
    
}
