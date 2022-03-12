//
//  DeputadoStrings.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 10/03/22.
//

import Foundation

extension String {
    struct basic {
        static var information: String { "Informações" }
        static var name: String { "Nome" }
        static var stateAcronym: String { "UF" }
        static var politicalParty: String { "Partido" }
        static var legislature: String { "Código Legislatura" }
    }
    
    struct cabinet {
        static var cabinetNumber: String { "Gabinete" }
        static var cabinetBuild: String { "Prédio" }
        static var cabinetRoom: String { "Sala" }
        static var cabinetFloor: String { "Andar" }
    }
    
    struct personal {
        static var info: String { "Informações pessoais" }
        static var email: String { "E-mail" }
        static var gender: String { "Genêro" }
        static var phone: String { "Telefone" }
        static var document: String { "CPF" }
        static var social: String { "Rede Social" }
        static var birthday: String { "Data Nascimento" }
        static var death: String { "Data Falecimento" }
        static var stateBirth: String { "Municipio Nascimento" }
        static var schooling: String { "Escolaridade" }
    }
    
    struct political {
        static var situation: String { "Situação" }
        static var condition: String { "Condição" }
        static var site: String { "Web Site" }
    }
}
