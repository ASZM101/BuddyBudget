import SwiftUI

struct EmergencyFunds: View {
    // URL for the Emergency Funds article
    private var url = URL(string: "http://localhost:8000/article0.html")
    
    var body: some View {
        // WebView component to display the content from the specified URL
        WebView(url: url)
        
    }
}

// Preview the EmergencyFunds view
#Preview {
    EmergencyFunds()
}
