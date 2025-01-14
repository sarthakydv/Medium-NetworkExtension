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
            NEFilterManager.shared().isEnabled = true
            NEFilterManager.shared().loadFromPreferences{error in
                if let  saveError = error {
                    print("Failed to save the filter configuration: \(saveError)")
                }
            }
        }
    }
    
    func askPermission(){
        NEFilterManager.shared().isEnabled = true
        NEFilterManager.shared().loadFromPreferences{error in
            if let  saveError = error {
                print("Failed to save the filter configuration: \(saveError)")
            }
        }
        if NEFilterManager.shared().providerConfiguration == nil {
            let newConfiguration = NEFilterProviderConfiguration()
            newConfiguration.organization = "Medium-NetworkExtension"
            newConfiguration.filterBrowsers = true
            newConfiguration.filterSockets = true
            NEFilterManager.shared().providerConfiguration = newConfiguration
        }
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
