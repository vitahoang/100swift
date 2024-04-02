//
//  ContentView.swift
//  BetterRest
//
//  Created by Vita Hoang on 4/1/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Text("When do you want to wake up?")
                            .font(.headline)
                            .padding([.top], 10)
                        HStack{
                            Spacer()
                            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
                            .padding([.bottom], 10)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("BetterRest").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try BetterSleep(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))

            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
