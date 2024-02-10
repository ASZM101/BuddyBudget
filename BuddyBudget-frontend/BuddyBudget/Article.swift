import SwiftUI

struct Article: View {
    // State variable to store the URL
    @State var url = URL(string: "")
    
    var body: some View {
        // Main content of the Article view
        Text("Learn Finacial Literacy")
            .font(.largeTitle.weight(.bold))
            .multilineTextAlignment(.center)
            .padding()
        
        // List of sections containing navigation links to articles and quizzes
        List {
            // Section for Emergency Funds
            Section {
                // Navigation link to EmergencyFunds view
                NavigationLink(destination: EmergencyFunds()) {
                    Text("Emergency Funds Article")
                }
                
                // Navigation link to Quiz view related to Emergency Funds
                NavigationLink(destination: Quiz()) {
                    Text("Emergency Funds Quiz")
                }
            } header: {
                Text("Emergency Funds") // Section header
            }
            
            // Section for Investments
            Section {
                // Navigation link to Investments view
                NavigationLink(destination: Investments()) {
                    Text("Investments Article")
                }
                
                // Navigation link to Quiz2 view related to Investments
                NavigationLink(destination: Quiz2()) {
                    Text("Emergency Funds Quiz")
                }
            } header: {
                Text("Investments") // Section header
            }
        }
        .listStyle(.sidebar) // Use sidebar list style
        .scrollContentBackground(.hidden) // Hide scroll content background
    }
}

// Preview the Article view
#Preview {
    Article()
}
