//
//  Date.swift
//  Life Weight
//
//  Created by 陳佩琪 on 2023/7/28.
//

import UIKit
import CodableCSV

struct Date: Codable{
    let date: Int
    let dateString: String
    let weightString: String
    let weight: Double
}

extension Date {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "Life Weight - Date")?.data {
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
