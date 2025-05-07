//
//  AddressView.swift
//  CupcakeCorner
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                        .onAppear {
                            let addressItems = [order.name, order.streetAddress, order.city, order.zip]
                            if let encoded = try? JSONEncoder().encode(addressItems) {
                                UserDefaults.standard.set(encoded, forKey: "addressItems")
                                print("Address Items kaydedildi.")
                            }
                        }
                }
            }
            .disabled(order.hasValidAddress == false)
           
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
