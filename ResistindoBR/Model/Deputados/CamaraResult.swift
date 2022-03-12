//
//  CamaraResult.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation

// MARK: - CamaraResult
struct CamaraResult: BaseResultData {
    var dados: [Deputado]
    var links: [Link]
}

// MARK: - Dado
struct Deputado: Decodable, Identifiable {
    let id: Int
    let nome: String
    let siglaPartido: String
    let siglaUf: String
    let legislatura: Int
    let uriPartido: String?
    let urlFoto: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nome
        case siglaPartido
        case siglaUf
        case urlFoto
        case email
        case uriPartido
        
        case legislatura = "idLegislatura"
    }
    
    var politicalPartyId: String {
        guard let uriPartido = uriPartido else { return .empty }
        if let lastIndex = uriPartido.lastIndex(of: "/") {
            return String(uriPartido[lastIndex...])
        }
        
        return .empty
    }
}

// MARK: - Link
struct Link: Decodable {
    let rel: String
    let href: String
}

// MARK: - PartidosResult
struct DeputadoDetailResult: Decodable {
    let dados: DeputadoDetail
}

// MARK: - Dados
struct DeputadoDetail: Decodable, Identifiable {
    let id: Int
    let uri: String
    let nomeCivil: String
    let ultimoStatus: UltimoStatus
    let cpf: String
    let sexo: String
    let urlWebsite: String?
    let redeSocial: [String]
    let dataNascimento: String
    let dataFalecimento: String?
    let ufNascimento: String
    let municipioNascimento: String
    let escolaridade: String
}

// MARK: - UltimoStatus
struct UltimoStatus: Decodable {
    let id: Int
    let nome: String
    let siglaPartido: String
    let siglaUf: String
    let idLegislatura: Int
    let urlFoto: String
    let uriPartido: String?
    let email: String
    let data: String
    let nomeEleitoral: String
    let gabinete: Gabinete
    let situacao: String
    let condicaoEleitoral: String
    let descricaoStatus: String?
}

// MARK: - Gabinete
struct Gabinete: Decodable {
    let nome: String
    let predio: String
    let sala: String
    let andar: String
    let telefone: String
    let email: String
}

struct InformationDetail: Identifiable {
    var id: Int
    var information: String
    var detail: String
}

struct SectionedInformationPolitians: Identifiable {
    var id: Int
    var name: String
    var informations: [InformationDetail]
    
    static func sectionedInformationDetail(detail: DeputadoDetail) -> [SectionedInformationPolitians] {
        
        var resultSection = [SectionedInformationPolitians]()
        
        var firstSection = [InformationDetail]()
        
        firstSection.append(InformationDetail(id: 1, information: .basic.name, detail: detail.nomeCivil))
        firstSection.append(InformationDetail(id: 2, information: .basic.stateAcronym, detail: detail.ultimoStatus.siglaUf))
        firstSection.append(InformationDetail(id: 3, information: .basic.politicalParty, detail: detail.ultimoStatus.siglaPartido))
        firstSection.append(InformationDetail(id: 4, information: .basic.legislature, detail: "\(detail.ultimoStatus.idLegislatura)"))
        
        resultSection.append(SectionedInformationPolitians(id: 1, name: String.basic.information, informations: firstSection))
    
        
        var secondSection = [InformationDetail]()
        
        secondSection.append(InformationDetail(id: 1, information: .cabinet.cabinetNumber, detail: detail.ultimoStatus.gabinete.nome))
        secondSection.append(InformationDetail(id: 2, information: .cabinet.cabinetBuild, detail: detail.ultimoStatus.gabinete.predio))
        secondSection.append(InformationDetail(id: 3, information: .cabinet.cabinetRoom, detail: detail.ultimoStatus.gabinete.sala))
        secondSection.append(InformationDetail(id: 4, information: .cabinet.cabinetFloor, detail: detail.ultimoStatus.gabinete.andar))
        
        resultSection.append(SectionedInformationPolitians(id: 2, name: String.cabinet.cabinetNumber, informations: secondSection))
        
        var thirdSection = [InformationDetail]()
        thirdSection.append(InformationDetail(id: 1, information: .personal.email, detail: detail.ultimoStatus.email))
        thirdSection.append(InformationDetail(id: 2, information: .personal.gender, detail: detail.sexo))
        thirdSection.append(InformationDetail(id: 3, information: .personal.phone, detail: detail.ultimoStatus.gabinete.telefone))
        thirdSection.append(InformationDetail(id: 4, information: .personal.document, detail: detail.cpf))
        thirdSection.append(InformationDetail(id: 5, information: .personal.birthday, detail: detail.dataNascimento))
        thirdSection.append(InformationDetail(id: 6, information: .personal.death, detail: detail.dataFalecimento ?? "Por enquanto não"))
        thirdSection.append(InformationDetail(id: 7, information: .personal.stateBirth, detail: detail.municipioNascimento))
        thirdSection.append(InformationDetail(id: 8, information: .personal.schooling, detail: detail.escolaridade))
        
        resultSection.append(SectionedInformationPolitians(id: 3, name: String.personal.info, informations: thirdSection))
        
        return resultSection
    }
}
