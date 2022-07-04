//
//  ProfileView.swift
//  Rawg.io
//
//  Created by Leafy on 07/06/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var showEditView = false
    
    @State private var name = ""
    @State private var email = ""
    @State private var profession = ""
    
    private func synchronizeData() {
        ProfileModel.synchronize()
        
        self.name = ProfileModel.name
        self.email = ProfileModel.email
        self.profession = ProfileModel.profession
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 48)
                Text("About Me")
                    .font(.system(size: 36).bold())
                Spacer(minLength: 72)
                Image("profile-picture")
                    .resizable()
                    .frame(width: 256, height: 256, alignment: .center)
                    .clipShape(Circle())
                Spacer(minLength: 16)
                Text(name)
                    .font(.system(size: 24))
                Text(email)
                Text(profession)
            }
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
            .onAppear(perform: synchronizeData)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showEditView = true
                        }
                }
            }
            .sheet(isPresented: $showEditView, onDismiss: synchronizeData) {
                EditView()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
