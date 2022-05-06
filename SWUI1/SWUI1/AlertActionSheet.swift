//
//  AlertActionSheet.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct AlertActionSheet: View {
    
    @State var showAlert: Bool = false
    @State var showActionSheet: Bool = false
    @State var backgroundColor: Color = Color.yellow
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 50) {
                
                // Alert
                Button("Click Alert") {
                    showAlert.toggle()
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("This is title"),
                          message: Text("This is some detail description"),
                          primaryButton: .destructive(Text("Delete"), action: {
                        print("Some Action Performed")
                        backgroundColor = .red
                    }),
                          secondaryButton: .cancel())
                })
                
                // Action Sheet
                Button("Click Action Sheet") {
                    showActionSheet.toggle()
                }
                .actionSheet(isPresented: $showActionSheet, content: getActionSheet)
                
            }
            
        }
    }
    
    func getActionSheet() -> ActionSheet {
        let button1: ActionSheet.Button = .default(Text("Orange")) {
            backgroundColor = .orange
        }
        let button2: ActionSheet.Button = .default(Text("Green")) {
            backgroundColor = .green
        }
        let button3: ActionSheet.Button = .destructive(Text("Destrictive")) {
            print("Destructive")
        }
        return ActionSheet(
            title: Text("Some action sheet title"),
            message: Text("Some action sheets super descriptive message"),
            buttons: [button1, button2, button3])
    }
    
}

struct AlertActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        AlertActionSheet()
    }
}
