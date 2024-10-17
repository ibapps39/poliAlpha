//
//  StateModel.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/16/24.
//

import SwiftUI

struct StateModel {
    let name: String
    let baseColor: Color   // Constant reference color
    var color: Color       // Current color that can change
    var influence: Double
}
