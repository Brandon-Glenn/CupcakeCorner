//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Brandon Glenn on 12/16/21.
//

import SwiftUI


struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Your Cake Type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                            
                        }
                    }
                    Stepper("Number Of Cakes: \(order.quantity)", value: $order.quantity)
                }
                
                Section{
                    Toggle("Any Special Requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Extra Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
                
                
            }
            .navigationTitle("CupcakeCorner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
