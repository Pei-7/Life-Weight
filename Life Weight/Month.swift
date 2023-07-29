//
//  Month.swift
//  Life Weight
//
//  Created by 陳佩琪 on 2023/7/28.
//

import UIKit
import CodableCSV

struct Month: Codable{
    let month: Int
    let monthString: String
    let weightString: String
    let weight: Double
}

extension Month {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "Life Weight - Month")?.data {
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
