//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Yashraj jadhav on 28/02/23.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        
        Form {
            Section {
                VStack(spacing: 15) {
                    TextField("Name", text: $order.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Street Address", text: $order.StreetAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("City", text: $order.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Zip", text: $order.zip)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(order.hasValidAddress ? Color.teal : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(!order.hasValidAddress)
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.gray))
        .cornerRadius(20)
        .padding()
    }
}


struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order : Order())
    }
}
