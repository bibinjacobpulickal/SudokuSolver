//
//  SudokuViewModel.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 15/03/21.
//

import SwiftUI

class SudokuViewModel: ObservableObject {

    var size: Size

    init(size: Size) {
        self.size = size
    }
}
