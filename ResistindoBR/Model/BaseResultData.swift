//
//  BaseResultData.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation

protocol BaseResultData: Decodable {
    associatedtype InnerData: Decodable
    var dados: [InnerData] { get }
    var links: [Link] { get }
}
