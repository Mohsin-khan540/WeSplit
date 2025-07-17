//
//  ContentView.swift
//  wesplit
//
//  Created by Mohsin khan on 17/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkBalance = 0.0
    @State private var NoOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
//    let tipPercentages = [15, 20, 25, 0]
    // computed property
    var totalPerPerson: Double{
        let peopleCount = Double(NoOfPeople + 2)
        let tipPercentage = Double(tipPercentage)
        let tipValue = checkBalance/100 * tipPercentage
        let grandTotal = checkBalance + tipValue
        let amountperPerson = grandTotal/peopleCount
        return amountperPerson
    }
    
    
    var body: some View {
        NavigationStack{
        Form{
           
                Section{
                    TextField("Check Balance", value: $checkBalance,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $NoOfPeople){
                        ForEach(2..<100){
                            Text("\($0) peoples")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            Section("How much tip do you want to give?"){
                Picker("tip percentage" , selection : $tipPercentage){
                    ForEach(0..<101){
                        Text("\($0)% tip")
                    }
                }
                .pickerStyle(.navigationLink)
//                .pickerStyle(.segmented)
            }
            Section("Total amount  without tip"){
                Text(checkBalance, format: .currency(code: "PKR"))
            }
           
                Section("Amount per person"){
                    Text(totalPerPerson,format: .currency(code: Locale.current.currency? .identifier ?? "USD") .precision(.fractionLength(2)))
                    
                }
            }
        .navigationTitle("Welcome to the cage cafe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if amountIsFocused{
                Button("Done"){
                    amountIsFocused = false
                }
            }
        }
            Section{
                Button("Reset"){
                    checkBalance=0
                    NoOfPeople=0
                    tipPercentage=20
                }
                .foregroundColor(.red)
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}


