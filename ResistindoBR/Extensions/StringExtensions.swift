//
//  StringExtensions.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation


extension String {
    static var empty: String { String() }
    
    func replacementPath(paths: [String: String]) -> String {
        var replacedString = self
        
        for item in paths {
            replacedString = replacedString.replacingOccurrences(of: "{\(item.key)}", with: item.value)
        }
        
        return replacedString
    }
}
