//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Yashraj jadhav on 28/02/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @ObservedObject var order : Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) {image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 223)
                
                Text("Your total is \(order.cost , format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order" ) {
                    Task{
                        await placeOrder()
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle(" Check Out ")
        .alert("Thank you ! ", isPresented: $showingConfirmation) {
            Button("OK") { }
            
        }message: {
            Text(confirmationMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    //Just like when we were downloading data using URLSession, uploading is also done asynchronously.
    
    /*
     
     Inside placeOrder() we need to do three things:
     
     Convert our current order object into some JSON data that can be sent.
     Tell Swift how to send that data over a network call.
     Run that request and process the response.
     
     */
    
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        //        The HTTP method of a request determines how data should be sent. There are several HTTP methods, but in practice only GET (“I want to read data”) and POST (“I want to write data”) are used much. We want to write data here, so we’ll be using POST.
        //        The content type of a request determines what kind of data is being sent, which affects the way the server treats our data. This is specified in what’s called a MIME type, which was originally made for sending attachments in emails, and it has several thousand highly specific options.
        
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("applications/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
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
