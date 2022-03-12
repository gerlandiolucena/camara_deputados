//
//  PaginatedBaseObject.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation

class PaginatedObject<DefaultResult: BaseResultData>: ObservableObject {
    @Published var result: DefaultResult? {
        didSet {
            isLoading = false
        }
    }
    
    @Published var isLoading = true
    
    var currentPage = 1
    
    var resultData: [DefaultResult.InnerData]?
}
