//
//  DataStore.swift
//  AppSpringboard
//
//  Created by Joseph Bergen on 7/14/18.
//  Copyright © 2018 Joseph Bergen. All rights reserved.
//

import Foundation

class DataStore {
    static let shared = DataStore()

    var adjectives = [String]()
    var animals = [String]()

    init() {
        adjectives = getTextContents(filename: "adjectives")
        animals = getTextContents(filename: "animals")
    }

    func dataArray(count: Int) -> [String] {
        let rndAdj = adjectives[randomPick: count]
        let rndAnimals = animals[randomPick: count]

        var combined = [String]()
        for index in 0..<rndAdj.count {
            combined.append("\(rndAdj[index].capitalizingFirstLetter()) \(rndAnimals[index])")
        }
        return combined
    }

    private func getTextContents(filename: String) -> [String] {
        guard let filepath = Bundle.main.path(forResource: filename, ofType: "txt") else { return [] }
        guard let contents = try? String(contentsOfFile: filepath) else { return [] }
        return contents.components(separatedBy: .newlines)
    }
}

private extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

private extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
