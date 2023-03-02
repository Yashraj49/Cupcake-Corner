//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Yashraj jadhav on 28/02/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        do {
                            try await placeOrder()
                            showingConfirmation = true
                        } catch {
                            errorMessage = "Checkout failed: \(error.localizedDescription)"
                            showErrorAlert = true
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() async throws {
        guard let encoded = try? JSONEncoder().encode(order) else {
            throw CheckoutError.encodingFailed
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        
        let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
        confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
    }
}

enum CheckoutError: Error {
    case encodingFailed
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
