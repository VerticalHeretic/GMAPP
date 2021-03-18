//
//  ContentView.swift
//  GMAPP
//
//  Created by Lukasz Stachnik on 18/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var games = [Game]()
    @State private var platform = "PC"
    
    private var pickerOrTab = true
    let platformTypes = ["PC", "PlayStation 4" ,"PlayStation 5", "Xbox Series X", "Xbox One","Switch", "Stadia"]
    
    var body: some View {
        ZStack{
            NavigationView {
                List(games) { game in
                    GameRow(game: game)
                }.navigationTitle("Games")
                .toolbar {
                        Picker("Platform", selection: $platform) {
                            ForEach(platformTypes, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
    
                }
                .onAppear() {
                    GameService().getGamesForPlatform(platform: platform, completion: { (games) in
                        self.games = games
                    })
                }
                .onChange(of: platform, perform: { platform in
                    GameService().getGamesForPlatform(platform: platform, completion: { (games) in
                        self.games = games
                    })
                })
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
