//
//  SudokuViewModel.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 15/03/21.
//

import SwiftUI

class SudokuViewModel: ObservableObject {

    var size: Size
    var userInputCells: Set<Cell> = []
    @Published var values = [[Int]]()
    @Published var selectedCell = (-1, -1)

    init(size: Size) {
        self.size = size
    }

    func updateValue(_ value: Int) {
        values[selectedCell.0][selectedCell.1] = value
        selectedCell = (-1, -1)
    }

    func delete() {
        values[selectedCell.0][selectedCell.1] = -1
        selectedCell = (-1, -1)
    }

    func selectCell(_ cell: (Int, Int)) {
        selectedCell = selectedCell == cell ? (-1, -1) : cell
    }

    func solve() {
        
    }
}

struct Cell: Hashable {
    var row, column: Int
}
