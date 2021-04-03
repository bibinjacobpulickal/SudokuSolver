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

    func deleteButtonDisabled() -> Bool {
        selectedCell == (-1, -1) || values[selectedCell.0][selectedCell.1] == -1
    }

    func buttonDisabled(_ value: Int) -> Bool {
        selectedCell == (-1, -1) || !checkIfValuePossible(value)
    }

    func checkIfValuePossible(_ value: Int) -> Bool {
        checkIfValue(value, possibleAt: selectedCell)
    }

    func checkIfValue(_ value: Int, possibleAt cell: (Int, Int)) -> Bool {
        for row in 0..<size.size {
            for column in 0..<size.size {
                if row == cell.0 || column == cell.1 || (Int(row/size.rawValue) == Int(cell.0/size.rawValue) && Int(column/size.rawValue) == Int(cell.1/size.rawValue)) {
                    if values[row][column] == value {
                        return false
                    }
                }
            }
        }
        return true
    }
}
