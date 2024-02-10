//
//  Article.swift
//  Financy
//
//  Created by Adriana Zambrano on 1/28/24.
//

import SwiftUI

struct Article: View {
    @State var url = URL(string: "")
    var body: some View {
        Text("Learn Finacial Literacy")
            .font(.largeTitle.weight(.bold))
            .multilineTextAlignment(.center)
            .padding()
        List {
            Section {
                NavigationLink(destination: EmergencyFunds()) {
                    Text("Emergency Funds Article")
                }
                NavigationLink(destination: Quiz()) {
                    Text("Emergency Funds Quiz")
                }
            } header: {
                Text("Emergency Funds")
            }
            Section {
                NavigationLink(destination: Investments()) {
                    Text("Investments Article")
                }
                NavigationLink(destination: Quiz2()) {
                    Text("Emergency Funds Quiz")
                }
            } header: {
                Text("Investments")
            }
        }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
    }
}
#Preview {
    Article()
}
