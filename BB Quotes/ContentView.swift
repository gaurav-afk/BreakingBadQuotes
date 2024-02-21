//
//  ContentView.swift
//  BB Quotes
//
//  Created by Gaurav Rawat on 2024-02-20.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        TabView{
            QuoteView(show: Constants.bbName)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            
            QuoteView(show: Constants.bcsName)
                .tabItem {
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
        }
        .onAppear{
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
    }

}

#Preview {
    ContentView()
}
