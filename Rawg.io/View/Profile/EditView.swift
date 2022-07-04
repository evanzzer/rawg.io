//
//  EditView.swift
//  Rawg.io
//
//  Created by Leafy on 12/06/22.
//

import SwiftUI

private struct AlertInfo: Identifiable {
    enum AlertCode {
        case empty
    }
    
    let id: AlertCode
    let title: String
    let message: String
    let button: String
}

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var profession: String = ""
    
    @State private var alertInfo: AlertInfo?
    
    private func getAlertTemplate(name: String) {
        alertInfo = AlertInfo(
            id: .empty,
            title: "Error",
            message: "\(name) is still empty.",
            button: "OK"
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Spacer(minLength: 16)
                Text("Name")
                    .font(.system(size: 16))
                TextField("Name", text: $name)
                    .padding(8)
                    .border(.black, width: 1)
                    
                Spacer(minLength: 12)
                Text("Email")
                    .font(.system(size: 16))
                TextField("email", text: $email)
                    .padding(8)
                    .border(.black, width: 1)

                Spacer(minLength: 12)
                Text("Profession")
                    .font(.system(size: 16))
                TextField("Profession", text: $profession)
                    .padding(8)
                    .border(.black, width: 1)
                
                HStack {
                    Button("Cancel") {
                        self.dismiss()
                    }.padding(16)
                    Spacer()
                    Button("Save") {
                        if name.isEmpty {
                            getAlertTemplate(name: "Name")
                        } else if email.isEmpty {
                            getAlertTemplate(name: "Email")
                        } else if profession.isEmpty {
                            getAlertTemplate(name: "Profession")
                        } else {
                            ProfileModel.name = name
                            ProfileModel.email = email
                            ProfileModel.profession = profession
                            
                            self.dismiss()
                        }
                    }.buttonStyle(.borderedProminent)
                }.padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
            }
            
        }.navigationTitle("Edit Profile")
            .onAppear {
                ProfileModel.synchronize()
                
                self.name = ProfileModel.name
                self.email = ProfileModel.email
                self.profession = ProfileModel.profession
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
            .alert(item: $alertInfo) { info in
                Alert(title: Text(info.title),
                      message: Text(info.message),
                      dismissButton: .default(Text(info.button)))
            }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
