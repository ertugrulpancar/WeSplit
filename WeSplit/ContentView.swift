//
//  ContentView.swift
//  WeSplit
//
//  Created by Ertuğrul Pancar on 21.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amaountIsFocused: Bool
    
    // let tipPercentages = [10, 15, 20, 25, 30, 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amaountIsFocused)
                }
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) People")
                    }
                }
                
                Section("How much do you want to tip?") {
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101) { percantege in
                            Text("\(percantege)%")
                            
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding()
                }
                Section("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amaountIsFocused {
                    Button("Done") {
                        amaountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
