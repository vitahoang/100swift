//
//  ContentView.swift
//  Challenge01
//
//  Created by Vita Hoang on 3/31/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var lengthInput: Double = 0.0
    let tipPercentages = [10, 15, 20, 25, 0]
    var inputUnit: String = "meter"
    var outputUnit: String = "feet"
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Input"){
                    TextField("Input Amount", value: $lengthInput, formatter: numberFormatter)
                    
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}

#Preview {
    ContentView()
}
