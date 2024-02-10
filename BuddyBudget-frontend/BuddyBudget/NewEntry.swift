import SwiftUI

struct NewEntry: View {
    // Shared instance of the APIManager
    let apiManager = APIManager.shared
    
    // Environment variable to dismiss the view
    @Environment(\.dismiss) private var dismiss
    
    // Binding variables for budget, withdrawals, deposits, expense flag, and entries
    @Binding var budget: Double
    @Binding var withdrawals: Double
    @Binding var deposits: Double
    @Binding var isExpense: Bool
    @Binding var entries: [String]
    
    // State variables for description, amount, amount string, and background colors
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
                Spacer()
                    .frame(maxHeight: 75)
                
                // Text field for description
                TextField("Description", text: $description)
                    .padding()
                    .background(Color(dBkgd))
                    .cornerRadius(20)
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                
                // Text field for amount
                TextField("Amount", text: $amountStr)
                    .padding()
                    .background(Color(aBkgd))
                    .cornerRadius(20)
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                    .keyboardType(.decimalPad)
                Spacer()
                    .frame(maxHeight: 25)
                
                // Button to add entry
                Button{
                    amount = Double(amountStr) ?? 0.0
                    
                    // Check for empty description
                    if(description == "") {
                        dBkgd = "lightRed"
                    } else {
                        dBkgd = "lightGrey"
                    }
                    
                    // Check for zero amount
                    if(amount == 0.0) {
                        aBkgd = "lightRed"
                    } else {
                        aBkgd = "lightGrey"
                    }
                    
                    // If both description and amount are valid, add the entry
                    if(description != "" && amount != 0.0){
                        print("\(APIManager.bearer)")
                        
                        // Update budget, withdrawals, and deposits based on the entry
                        if(isExpense) {
                            withdrawals += amount
                            budget -= amount
                        } else {
                            deposits += amount
                            budget += amount
                        }
                        
                        // Append the entry to the entries array
                        entries.append((isExpense ? "- $" : "+ $") + String(format: "%.2f", round(amount * 100) / 100.0) + " (Date) " + description)
                        
                        // Adjust the amount for expenses (negative)
                        var am = amount;
                        if (isExpense) {
                            am *= -1
                        }
                        
                        // Call APIManager to record the transaction
                        apiManager.transaction(forWhat: description, amount: am)
                        
                        // Dismiss the view
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
                .padding()
                Spacer()
                    .frame(maxHeight: 25)
            }
        }
    }
}
