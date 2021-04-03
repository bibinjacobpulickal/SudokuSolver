//
//  SudokuView.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 14/03/21.
//

import SwiftUI

struct SudokuView: View {

    @StateObject var viewModel: SudokuViewModel

    init(size: Size) {
        _viewModel = StateObject(wrappedValue: .init(size: size))
    }

    var body: some View {
        VStack {
            sudokuGrid
            numberPad
            solveButton
        }
        .padding()
        .onAppear(perform: viewModel.reset)
    }

    var sudokuGrid: some View {
        GeometryReader { proxy in
            VStack {
                ForEach(0..<viewModel.values.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.values[row].count, id: \.self) { column in
                            Button(action: {
                                viewModel.selectCell((row, column))
                            }) {
                                Text(viewModel.values[row][column] == -1 ? "" : "\(viewModel.values[row][column])")
                                    .font(.largeTitle)
                                    .fontWeight(viewModel.selectedCell == (row, column) ? .bold : .regular)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(viewModel.selectedCell == (row, column) ? Color.gray.opacity(0.25) : .clear)
                            }
                            .border(size: viewModel.size, cell: (row, column))
                        }
                        .frame(width: min(proxy.size.width, proxy.size.height)/CGFloat(viewModel.size.size),
                               height: min(proxy.size.width, proxy.size.height)/CGFloat(viewModel.size.size))
                    }
                }
            }
        }
    }

    var numberPad: some View {
        VStack {
            ForEach(0..<viewModel.size.rawValue, id: \.self) { row in
                HStack {
                    ForEach(0..<viewModel.size.rawValue, id: \.self) { column in
                        let value = viewModel.size.rawValue * row + column + 1
                        Button(action: {
                            viewModel.updateValue(value)
                        }) {
                            Text("\(value)")
                                .bold()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.white)
                                .background(viewModel.buttonDisabled(value) ? Color.gray : .blue)
                                .cornerRadius(8)
                                .padding(2)
                        }
                        .disabled(viewModel.buttonDisabled(value))
                    }
                }
            }
            Button(action: viewModel.delete) {
                Image(systemName: "delete.left")
                    .frame(width: 44, height: 44)
                    .foregroundColor(.black)
                    .background(viewModel.deleteButtonDisabled() ? Color.gray : .red)
                    .cornerRadius(8)
                    .padding(2)
            }
            .disabled(viewModel.deleteButtonDisabled())
        }
    }

    var solveButton: some View {
        HStack {
            Button(action: viewModel.reset) {
                Text("RESET")
                    .bold()
                    .foregroundColor(.black)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(8)
            }
            Button(action: viewModel.solve) {
                Text(viewModel.isSolved ? "SOLVED!" : "SOLVE")
                    .bold()
                    .foregroundColor(.black)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isSolvable ? viewModel.isSolved ? Color.green : .blue : .red)
                    .cornerRadius(8)
            }
        }
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView(size: .three)
    }
}

extension View {

    func border(size: Size, cell: (Int, Int)) -> some View {
        modifier(BorderModifier(size: size, cell: cell))
    }

    func border(_ color: Color, edges: [Edge], width: CGFloat) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}
