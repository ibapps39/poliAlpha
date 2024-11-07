//
//  PolicyView.swift
//  poliAlpha
//
//  Created by Ian Brown on 10/17/24.
//

import SwiftUI

let RECTANGLES = Array(1...10)
// Example Policies to be used in PolicyView
let ExamplePolicies: [PolicyModel] = [
    PolicyModel(name: "Tarrif", description: "A tarrif on a foreign produced good.", baseInfluenceModifier: -1.0, isEnabled: false, cost: 20),
    PolicyModel(name: "Increase Taxes", description: "Increase taxes to boost government spending.", baseInfluenceModifier: 0.1, isEnabled: true, cost: 50),
    PolicyModel(name: "Cut Military Spending", description: "Reduce military spending to fund other domestic programs.", baseInfluenceModifier: -0.05, isEnabled: true, cost: 30),
    PolicyModel(name: "Universal Healthcare", description: "Implement a national healthcare system to provide universal coverage.", baseInfluenceModifier: 0.15, isEnabled: false, cost: 100),
    PolicyModel(name: "Free Education", description: "Provide free education for all citizens up to university level.", baseInfluenceModifier: 0.1, isEnabled: true, cost: 80),
    PolicyModel(name: "Environmental Protection Act", description: "Enforce stricter environmental regulations to protect natural resources.", baseInfluenceModifier: 0.05, isEnabled: true, cost: 60),
    PolicyModel(name: "Increase Minimum Wage", description: "Raise the minimum wage to improve living standards for workers.", baseInfluenceModifier: 0.05, isEnabled: true, cost: 40),
    PolicyModel(name: "Corporate Tax Cuts", description: "Lower corporate taxes to stimulate business investment and job creation.", baseInfluenceModifier: -0.1, isEnabled: true, cost: 50),
    PolicyModel(name: "Gun Control", description: "Implement stricter gun control laws to reduce violence and crime.", baseInfluenceModifier: 0.05, isEnabled: false, cost: 20),
    PolicyModel(name: "Healthcare for Veterans", description: "Provide free healthcare to veterans of the armed forces.", baseInfluenceModifier: 0.05, isEnabled: true, cost: 25),
    PolicyModel(name: "Tax the Rich", description: "Increase taxes on the wealthiest citizens to reduce inequality.", baseInfluenceModifier: 0.2, isEnabled: true, cost: 70)
]


struct PolicyView: View {
    @State var selectedPolicy: PolicyModel? = nil
    var body: some View {
        ZStack {
            Image("png_policy2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            LazyHStack {
                ScrollView(.vertical) {
                    ForEach(ExamplePolicies, id:\.name) { policy in
                        Button(action: { selectedPolicy = policy }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Text("\(policy.name.prefix(policy.name.count/2))")
                                        .font(.title3)
                                        .bold()
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 250, height: 400)
                    .overlay(
                        VStack {
                            Text(selectedPolicy?.name ?? ExamplePolicies.first!.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            Text(selectedPolicy?.description ?? ExamplePolicies.first!.description)
                                .font(.body)
                                .padding([.top, .bottom], 10)
                            
                            Text("Influence Modifier: \(selectedPolicy?.baseInfluenceModifier ?? ExamplePolicies.first!.baseInfluenceModifier, specifier: "%.2f")")
                                .font(.subheadline)
                                .padding(.bottom, 10)
                            
                            Text("Cost: $\(selectedPolicy?.cost ?? 0, specifier: "%.1i")")
                                .font(.subheadline)
                            Button(action: {}) {
                                Text("Purchase")
                                    .bold()
                                    .frame(width: 100, height: 40)
                                    .foregroundStyle(.white)
                                    .background(Color.green)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    )
            }
        }
    }
}

#Preview {
    PolicyView()
}
