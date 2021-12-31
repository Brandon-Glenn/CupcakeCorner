//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Brandon Glenn on 12/29/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                }
                Text("Your total cost is \(order.orderDetails.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                
                Button("Place Order")  {
                    Task {
                        await placeOrder()
                    }
                }
                
            }
            .navigationTitle("Check Out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank You", isPresented: $showingConfirmation) {
                Button("Ok") {} }
            message: {
            Text(confirmationMessage)
            }
        }
        
    }
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.orderDetails) else {
            print ("Failed to Encode Order")
            return
        }
        
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print(data)
            // handle the result
            let decodedOrder = try JSONDecoder().decode(OrderDetails.self, from: data)
            confirmationMessage = "Your Order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way"
        
            showingConfirmation = true

        } catch {
            print("Checkout failed.")
        }
        
        
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
