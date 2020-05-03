//
//  TestModalView.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-24.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State var presentingModal = false

    var body: some View {
        Button("Present") { self.presentingModal = true }
            .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal) }
    }
}

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    var body: some View {
        Button("dismiss") { self.presentedAsModal = false }
    }
}
