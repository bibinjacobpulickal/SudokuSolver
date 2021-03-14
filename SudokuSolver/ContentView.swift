//
//  ContentView.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 14/03/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Choose size")) {
                    ForEach(Size.allCases) {
                        NavigationLink($0.text,
                                       destination: SudokuView(size: $0))
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Sudoku Solver")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
