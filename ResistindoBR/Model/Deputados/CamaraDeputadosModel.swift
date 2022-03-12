//
//  CamaraDeputadosModel.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation

class CamaraDeputadosModel: PaginatedObject<CamaraResult> {
    @Published var partido: Partido?
    @Published var nomeDeputado = ""
    
    override var resultData: [Deputado]? {
        didSet {
            guard let newResult = result, let deputs = resultData else { return }
            var fullDeputados = newResult.dados
            fullDeputados.append(contentsOf: deputs)
            result = CamaraResult(dados: fullDeputados, links: newResult.links)
        }
    }
}


