//
//  SendableDemo.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 6/22/22.
//

import SwiftUI

actor CurrentUserManager {
    
    // Here we are using class inside the actor
    func updateDatabase(userInfo: MyClassUserInfo) {
        print("UPDATED--")
    }
}

//struct MyUserInfo: Sendable {
//    var name: String
//}


/**
 Sendable - Thread Safe Class
 */
final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    
    // We make this class thread-safe ourselves to use in the actor
    let queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
    
}

class SendableDemoViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyClassUserInfo(name: "INFO")
        
        await manager.updateDatabase(userInfo: info)
    }
}




struct SendableDemo: View {
    
    @StateObject private var viewModel = SendableDemoViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await viewModel.updateCurrentUserInfo()
            }
    }
}

struct SendableDemo_Previews: PreviewProvider {
    static var previews: some View {
        SendableDemo()
    }
}
