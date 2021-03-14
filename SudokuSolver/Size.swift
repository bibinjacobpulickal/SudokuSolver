//
//  Size.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 15/03/21.
//

import Foundation

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
