//
//  GroupListContainerView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import SwiftUI

struct GroupListContainerView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New Group") {
                    isPresented = true
                }
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            AddNewGroupView()
        }
    }
}

#Preview {
    GroupListContainerView()
}
