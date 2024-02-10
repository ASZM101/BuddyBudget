import SwiftUI

struct Investments: View {
    // URL for the Investments article
    private var url = URL(string: "http://localhost:8000/article1.html")
    
    var body: some View {
        // WebView component to display the content from the specified URL
        WebView(url: url)
    }
}

// Preview the Investments view
#Preview {
    Investments()
}
