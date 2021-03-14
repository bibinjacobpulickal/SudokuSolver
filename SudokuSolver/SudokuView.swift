//
//  SudokuView.swift
//  SudokuSolver
//
//  Created by Bibin Jacob Pulickal on 14/03/21.
//

import SwiftUI

struct SudokuView: View {

    var size: Size
    @State private var values = [[Int]]()
    @State private var selectedCell = (-1, -1)

    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    ForEach(0..<values.count, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<values[row].count, id: \.self) { column in
                                Button(action: {
                                        selectedCell = (row, column)
                                }) {
                                    Text(values[row][column] == -1 ? "" : "\(values[row][column])")
                                        .font(.largeTitle)
                                        .fontWeight(Bool.random() ? .regular : .bold)
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                .border(Color.primary, edges: [.top], width: row.isMultiple(of: size.rawValue) ? 4 : 1)
                                .border(Color.primary, edges: [.leading], width: column.isMultiple(of: size.rawValue) ? 4 : 1)
                                .border(Color.primary, edges: [.bottom], width: row == size.size - 1 ? 4 : 1)
                                .border(Color.primary, edges: [.trailing], width: column == size.size - 1 ? 4 : 1)
                            }
                            .frame(width: min(proxy.size.width, proxy.size.height)/CGFloat(size.size),
                                   height: min(proxy.size.width, proxy.size.height)/CGFloat(size.size))
                        }
                    }
                }
            }
            VStack {
                ForEach(0..<size.rawValue, id: \.self) { row in
                    HStack {
                        ForEach(0..<size.rawValue, id: \.self) { column in
                            Button(action: {
                                values[selectedCell.0][selectedCell.1] = size.rawValue * row + column + 1
                                selectedCell = (-1, -1)
                            }) {
                                Text("\(size.rawValue * row + column + 1)")
                                    .bold()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.white)
                                    .background(selectedCell == (-1, -1) ? Color.gray : .blue)
                                    .cornerRadius(8)
                                    .padding(2)
                            }
                            .disabled(selectedCell == (-1, -1))
                        }
                    }
                }
                Button(action: {
                    values[selectedCell.0][selectedCell.1] = -1
                    selectedCell = (-1, -1)
                }) {
                    Image(systemName: "delete.left")
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                        .background(selectedCell == (-1, -1) ? Color.gray :
                                        values[selectedCell.0][selectedCell.1] == -1 ? .gray : .red)
                        .cornerRadius(8)
                        .padding(2)
                }
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("SOLVE")
                    .bold()
                    .foregroundColor(.black)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            values = Array(repeating: Array(repeating: -1, count: size.size), count: size.size)
        }
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView(size: .three)
    }
}

extension View {
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
