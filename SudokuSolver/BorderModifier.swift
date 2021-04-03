//
//  BorderModifier.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 03/04/21.
//

import SwiftUI

struct BorderModifier: ViewModifier {

    var size: Size
    var cell: (row: Int, column: Int)

    func body(content: Content) -> some View {
        content
            .border(Color.primary, edges: [.top], width: cell.row.isMultiple(of: size.rawValue) ? 4 : 1)
            .border(Color.primary, edges: [.leading], width: cell.column.isMultiple(of: size.rawValue) ? 4 : 1)
            .border(Color.primary, edges: [.bottom], width: cell.row == size.size - 1 ? 4 : 1)
            .border(Color.primary, edges: [.trailing], width: cell.column == size.size - 1 ? 4 : 1)
    }
}
