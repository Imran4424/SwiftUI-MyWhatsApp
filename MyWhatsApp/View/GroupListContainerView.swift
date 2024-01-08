//
//  GroupListContainerView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import SwiftUI

struct GroupListContainerView: View {
    @EnvironmentObject private var userModel: UserModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New Group") {
                    isPresented = true
                }
            }
            
            GroupListView(groups: userModel.groups)
            
            Spacer()
        }
        .task {
            do {
                try await userModel.populateGroups()
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
        .environmentObject(UserModel())
}
