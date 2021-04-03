//
//  SudokuViewModel.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 15/03/21.
//

import SwiftUI

class SudokuViewModel: ObservableObject {

    var size: Size
    @Published var values = [[Int]]()
    @Published var selectedCell = (-1, -1)

    init(size: Size) {
        self.size = size
    }

    func selectCell(_ cell: (Int, Int)) {
        selectedCell = selectedCell == cell ? (-1, -1) : cell
    }

    func solve() {
        
    }
}
