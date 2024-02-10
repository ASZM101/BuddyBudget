//
//  NewEntry.swift
//  Financy
//
//  Created by Adriana Zambrano on 1/27/24.
//

import SwiftUI

struct NewEntry: View {
    let apiManager = APIManager.shared
    @Environment(\.dismiss) private var dismiss
    @Binding var budget: Double
    @Binding var withdrawals: Double
    @Binding var deposits: Double
    @Binding var isExpense: Bool
    @Binding var entries: [String]
    @State var description: String = ""
    @State var amount: Double = 0.0
    @State var amountStr: String = ""
    @State var dBkgd = "lightGrey"
    @State var aBkgd = "lightGrey"
    var body: some View {
        NavigationView {
            VStack {
                Text("New Entry")
                    .font(.largeTitle.weight(.bold))
                    .padding()
                TextField("Description", text: $description)
                    .padding()
                    .background(Color(dBkgd))
                    .cornerRadius(20)
                    .padding()
                TextField("Amount", text: $amountStr)
                    .padding()
                    .background(Color(aBkgd))
                    .cornerRadius(20)
                    .padding()
                    .keyboardType(.decimalPad)
                    Button{
                        amount = Double(amountStr) ?? 0.0
                        if(description == "") {
                            dBkgd = "lightRed"
                        } else {
                            dBkgd = "lightGrey"
                        }
                        if(amount == 0.0) {
                            aBkgd = "lightRed"
                        } else {
                            aBkgd = "lightGrey"
                        }
                        if(description != "" && amount != 0.0){
                            print("\(APIManager.bearer)")
                            if(isExpense) {
                                withdrawals += amount
                                budget -= amount
                            } else {
                                deposits += amount
                                budget += amount
                            }
                            entries.append((isExpense ? "- $" : "+ $") + String(amount) + " (01/28/2024) " + description)
                            
                            var am = amount;
                            if (isExpense) {
                                am *= -1
                            }
                            apiManager.transaction(forWhat: description, amount: am)
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add Entry")
                            Spacer()
                        }
                        .frame(width: 150)
                    }
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(.capsule)
                Spacer()
            }
        }
    }
}
