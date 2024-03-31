//
//  ContentView.swift
//  Challenge01
//
//  Created by Vita Hoang on 3/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputAmount: Double = 0.0
    @State private var output: Double = 0.0
    @State private var inputUnit = "m"
    @State private var outputUnit = "ft"
    let unitTypes = ["m", "km", "ft", "yd", "mi"]

    @FocusState private var keyboardFocused: Bool

    func assignInput(inputAmount: Double, inputUnit: String) -> Measurement<UnitLength> {
        switch inputUnit {
        case "m":
            return Measurement(value: inputAmount, unit: UnitLength.meters)
        case "km":
            return Measurement(value: inputAmount, unit: UnitLength.kilometers)
        case "ft":
            return Measurement(value: inputAmount, unit: UnitLength.feet)
        case "yd":
            return Measurement(value: inputAmount, unit: UnitLength.yards)
        case "mi":
            return Measurement(value: inputAmount, unit: UnitLength.miles)
        default:
            return Measurement(value: inputAmount, unit: UnitLength.meters)
        }
    }

    func convertOutput(input: Measurement<UnitLength>, outputUnit: String) -> Measurement<UnitLength> {
        switch outputUnit {
        case "m":
            return input.converted(to: UnitLength.meters)
        case "km":
            return input.converted(to: UnitLength.kilometers)
        case "ft":
            return input.converted(to: UnitLength.feet)
        case "yd":
            return input.converted(to: UnitLength.yards)
        case "mi":
            return input.converted(to: UnitLength.miles)
        default:
            return input.converted(to: UnitLength.meters)
        }
    }

    func assignOutput(inputAmount: Double, inputUnit: String, outputUnit: String) -> Double {
        let inAmount = assignInput(inputAmount: inputAmount, inputUnit: inputUnit)
        let outAmount = convertOutput(input: inAmount, outputUnit: outputUnit)
        return outAmount.value
    }

    @State private var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumIntegerDigits = 10
        nf.maximumFractionDigits = 2
        nf.positiveFormat = "#,##0.##"
        return nf
    }()

    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Input Amount", value: $inputAmount, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                        .focused($keyboardFocused)
                        .onChange(of: inputAmount) {
                            output = assignOutput(inputAmount: inputAmount, inputUnit: inputUnit, outputUnit: outputUnit)
                        }
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: inputUnit) {
                        output = assignOutput(inputAmount: inputAmount, inputUnit: inputUnit, outputUnit: outputUnit)
                    }
                }
                .listRowSeparator(.hidden)

                Section("Output") {
                    TextField("Input Amount", value: $output, formatter: numberFormatter).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: outputUnit) {
                        output = assignOutput(inputAmount: inputAmount, inputUnit: inputUnit, outputUnit: outputUnit)
                    }
                }
                .listRowSeparator(.hidden)
                .navigationTitle("Length Converter")
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        keyboardFocused = false
                        output = assignOutput(inputAmount: inputAmount, inputUnit: inputUnit, outputUnit: outputUnit)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
