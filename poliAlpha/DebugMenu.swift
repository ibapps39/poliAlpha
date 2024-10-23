//
//  DebugMenu.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/21/24.
//

import SwiftUI
// Toggle to indicate if metal is being used
var isMetal: Bool = false
struct DebugMenu: View {
    var body: some View {
        VStack {
            Text("MTLCreateSystemDefaultDevice()?\n.hasUnifiedMemory == \(MTLCreateSystemDefaultDevice()?.hasUnifiedMemory == true)")
            Text("isMetal: \(isMetal)")
        }
        
    }
}

#Preview {
    DebugMenu()
}
