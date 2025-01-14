//
//  ContentView.swift
//  Medium-NetworkExtension
//
//  Created by Dason Tiovino on 14/01/25.
//

import SwiftUI
import NetworkExtension

struct ContentView: View {
    var body: some View {
        VStack {
            Button{
                askPermission()
            }label:{
                Text("Ask Permission")
            }
        }
        .padding()
        .onAppear{
            // MARK: Load NetworkExtension
            NEFilterManager.shared().loadFromPreferences{error in
                if let  saveError = error {
                    print("Failed to save the filter configuration: \(saveError)")
                }
            }
        }
    }
    
    func askPermission(){
        // MARK: Configure Provider
        if NEFilterManager.shared().providerConfiguration == nil {
            let newConfiguration = NEFilterProviderConfiguration()
            newConfiguration.organization = "Medium-NetworkExtension"
            newConfiguration.filterBrowsers = true
            newConfiguration.filterSockets = true
            NEFilterManager.shared().providerConfiguration = newConfiguration
        }
        NEFilterManager.shared().isEnabled = true
        NEFilterManager.shared().saveToPreferences { error in
            if let  saveError = error {
                print("Failed to save the filter configuration: \(saveError)")
            }
        }
    }
}

#Preview {
    ContentView()
}
