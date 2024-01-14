//
//  GroupListContainerView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import SwiftUI

struct GroupListContainerView: View {
    @EnvironmentObject private var model: Model
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New Group") {
                    isPresented = true
                }
            }
            
            GroupListView(groups: model.groups)
            
            Spacer()
        }
        .task {
            do {
                try await model.populateGroups()
            } catch {
                print(error)
            }
            
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            AddNewGroupView()
        }
    }
}

#Preview {
    GroupListContainerView()
        .environmentObject(Model())
}
