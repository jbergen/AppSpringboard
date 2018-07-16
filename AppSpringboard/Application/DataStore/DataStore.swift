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
    var colors = [Color]()

    init() {
        adjectives = getTextContents(filename: "adjectives")
        animals = getTextContents(filename: "animals")
        colors = {
            guard let colorDict = getJSON(filename: "colors") else { return [] }
            guard let arr = colorDict["colors"] as? [Dictionary<String, AnyObject>] else { return [] }
            return arr.compactMap { entry in
                guard let name = entry["name"] as? String else { return nil }
                guard let hex = entry["hex"] as? String else { return nil }
                return Color(name: name, hex: hex)
            }
        }()
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
        guard let path = Bundle.main.path(forResource: filename, ofType: "txt") else { return [] }
        guard let contents = try? String(contentsOfFile: path) else { return [] }
        return contents.components(separatedBy: .newlines)
    }

    private func getJSON(filename: String) -> Dictionary<String, AnyObject>? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { return nil }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return nil }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else { return nil }
        return jsonResult as? Dictionary<String, AnyObject>
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
