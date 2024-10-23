//
//  PolicyView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import SwiftUI

struct PolicyView: View {
    
    var body: some View {
        ZStack {
            Image("png_policy2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    PolicyView()
}
