//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Brandon Glenn on 12/29/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderDetails.name)
                TextField("Street Address", text: $order.orderDetails.streetAddress)
                TextField("City", text: $order.orderDetails.city)
                TextField("Zip", text: $order.orderDetails.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check Out")
                }
            }
            .disabled (order.orderDetails.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
