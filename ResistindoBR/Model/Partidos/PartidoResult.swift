//
//  PartidoResult.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation

protocol Politician: Decodable, Identifiable {
    var id: Int { get set }
    var sigla: String { get set }
    var nome: String { get set }
    var uri: String { get set }
}

struct PartidosResult: BaseResultData {
    var dados: [Partido]
    var links: [Link]
}

// MARK: - Partido
struct Partido: Politician {
    var id: Int
    var sigla: String
    var nome: String
    var uri: String
}

// MARK: - PoliticalPartyDetailResult
struct PoliticalPartyDetailResult: Decodable {
    let dados: PoliticalPartyDetail
    let links: [Link]
}

// MARK: - Dados
struct PoliticalPartyDetail: Politician {
    var id: Int
    var sigla: String
    var nome: String
    var uri: String
    
    let status: Status
    let numeroEleitoral: String?
    let urlLogo: String
    let urlWebSite: String?
    let urlFacebook: String?
}

// MARK: - Status
struct Status: Decodable {
    let data: String
    let idLegislatura: String
    let situacao: String
    let totalPosse: String
    let totalMembros: String
    let uriMembros: String
    let lider: Deputado
}

