//
//  ContentView.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 14/03/21.
//

import SwiftUI

enum Size: Int, Identifiable, CaseIterable {
    var id: Int { rawValue }
    case two = 2
    case three
    case four

    var text: String {
        switch self {
        case .two: return "2 x 2"
        case .three: return "3 x 3"
        case .four: return "4 x 4"
        }
    }

    var size: Int {
        Int(pow(Double(rawValue), Double(2)))
    }
}

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
