//
//  ArrayExtensions.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 09/03/22.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    
    var toQuery: String {
        "&" + self.compactMap { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}
