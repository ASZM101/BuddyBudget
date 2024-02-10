import SwiftUI

struct Investments: View {
    private var url = URL(string: "http://localhost:8000/article1.html")
    var body: some View {
        WebView(url: url)
    }
}

#Preview {
    Investments()
}
