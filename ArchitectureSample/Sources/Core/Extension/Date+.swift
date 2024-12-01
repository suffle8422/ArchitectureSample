//
//  Date+.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Foundation

extension Date {
    public var formattedString: String {
        let dateFormatter = makeFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss")
        return dateFormatter.string(from: self)
    }

    private func makeFormatter(dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }

}
