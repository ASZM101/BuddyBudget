//
//  EmergencyFunds.swift
//  Financy
//
//  Created by Adriana Zambrano on 1/28/24.
//

import SwiftUI

struct EmergencyFunds: View {
    private var url = URL(string: "http://localhost:8000/article0.html")
    var body: some View {
        WebView(url: url)
        
    }
}

#Preview {
    EmergencyFunds()
}
