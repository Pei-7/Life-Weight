//
//  Year.swift
//  Life Weight
//
//  Created by 陳佩琪 on 2023/7/28.
//

import UIKit
import CodableCSV


struct Year :Codable {
    let year: Int
    let yearString: String
    let weightString: String
    let weight: Double
    let zodiacString: String
    let zodiacImageName: String
}

extension Year {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "Life Weight - Year")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}
