//
//  ContentView.swift
//  Financy
//
//  Created by Adriana Zambrano on 1/27/24.
//

import SwiftUI

struct ContentView: View {
    let apiManager = APIManager.shared
    @State var budget: Double = 0.0
    @State var withdrawals: Double = 0.0
    @State var deposits: Double = 0.0
    @State var isExpense: Bool = false
    @State var entries = [""]
    @State var clear = false
     
    var body: some View {
        NavigationView {
            VStack {
                Text("Balance: $" + String(budget))
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .onAppear() {
                        print("appearing")
                        apiManager.get_transactions {
                            transactions in
                            
                            //formatted as
                            //+/- $[amount] (MM/DD/YYYY) [reason]
                            entries = [""]
                            withdrawals = 0
                            deposits = 0
                            for transaction in transactions {
                                var entry = ""
                                if (transaction.amount < 0) {
                                    entry.append("- $")
                                    withdrawals -= transaction.amount
                                } else {
                                    entry.append("+ $")
                                    deposits += transaction.amount
                                }
                                let timestamp = TimeInterval(transaction.timestamp)
                                let converted = apiManager.as_converted(timestamp: timestamp, format: "MM/dd/yyyy")
                                entry.append("\(abs(transaction.amount)) (\(converted)) \(transaction.name)")
                                entries.append(entry)
                            }
                            budget = deposits - withdrawals
                        }
                    }
                ProgressView(value: withdrawals, total: deposits)
                    .progressViewStyle(.linear)
                    .padding()
                    .tint(.yellow)
                HStack {
                    Text("$" + String(withdrawals) + "\nwithdrawn")
                        .font(.title3.weight(.semibold))
                    Spacer()
                    Text("$" + String(deposits) + "\ndeposited")
                        .font(.title3.weight(.semibold))
                }
                .padding()
                .multilineTextAlignment(.center)
                
                List {
                    
                    if entries[0] == "" && entries.count == 1 {
                        HStack {
                            Spacer()
                            Text("No entries")
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                    } else {
                        ForEach(entries, id: \.self) { entry in
                            Text(entry)
                        }
                    }
                }
                .listStyle(.inset)
                .onAppear() {
                    print("\(entries.count)")
                }
                HStack {
                    NavigationLink(destination: NewEntry(budget: $budget, withdrawals: $withdrawals, deposits: $deposits, isExpense: .constant(false), entries: $entries)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button {
                        clear = true
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color("darkGrey"))
                    }
                    .alert("Are you sure you want to erase all your entries and reset your balance?", isPresented: $clear) {
                        Button("Yes", role: .destructive) {
                            entries = [""]
                            withdrawals = 0.0;
                            deposits = 0.0;
                            budget = 0.0
                            apiManager.drop_all()
                        }
                        Button("No", role: .cancel) {
                            
                        }
                    }
                    Spacer()
                    NavigationLink(destination: Article()) {
                        Image(systemName: "book.closed.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    NavigationLink(destination: NewEntry(budget: $budget, withdrawals: $withdrawals, deposits: $deposits, isExpense: .constant(true), entries: $entries)) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
            .onAppear() {
                budget = deposits - withdrawals
            }
        }
    }
}

#Preview {
    ContentView()
}
