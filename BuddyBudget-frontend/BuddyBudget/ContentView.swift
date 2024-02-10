import SwiftUI

struct ContentView: View {
    // Create an instance of the shared APIManager
    let apiManager = APIManager.shared
    
    // State variables to track budget, withdrawals, deposits, expense/income flag, entries, and clear flag
    @State var budget: Double = 0.0
    @State var withdrawals: Double = 0.0
    @State var deposits: Double = 0.0
    @State var isExpense: Bool = false
    @State var entries = [""]
    @State var clear = false
    
    var body: some View {
        // Main navigation view
        NavigationView {
            VStack {
                // Display balance and fetch transactions on view appear
                Text("Balance: $" + String(String(format: "%.2f", round(budget * 100) / 100.0)))
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .onAppear() {
                        // Fetch transactions from APIManager
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
                
                // Display progress bar, withdrawn and deposited amounts
                ProgressView(value: withdrawals, total: deposits)
                    .progressViewStyle(.linear)
                    .padding()
                    .tint(.yellow)
                HStack {
                    Text("$" + String(String(format: "%.2f", round(withdrawals * 100) / 100.0)) + "\nwithdrawn")
                        .font(.title3.weight(.semibold))
                    Spacer()
                    Text("$" + String(String(format: "%.2f", round(deposits * 100) / 100.0)) + "\ndeposited")
                        .font(.title3.weight(.semibold))
                }
                .padding()
                .multilineTextAlignment(.center)
                
                // Display the list of entries or a message if there are no entries
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
                
                // Horizontal stack with navigation links and buttons for adding, clearing, and viewing articles
                HStack {
                    // Navigation link to add a new expense
                    NavigationLink(destination: NewEntry(budget: $budget, withdrawals: $withdrawals, deposits: $deposits, isExpense: .constant(true), entries: $entries)) {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    
                    // Button to clear all entries with an alert confirmation
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
                    
                    // Navigation link to view articles
                    NavigationLink(destination: Article()) {
                        Image(systemName: "book.closed.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    
                    // Navigation link to add a new income
                    NavigationLink(destination: NewEntry(budget: $budget, withdrawals: $withdrawals, deposits: $deposits, isExpense: .constant(false), entries: $entries)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
            .padding()
            .onAppear() {
                // Update the budget on view appear
                budget = deposits - withdrawals
            }
        }
    }
}

// Preview the ContentView
#Preview {
    ContentView()
}
