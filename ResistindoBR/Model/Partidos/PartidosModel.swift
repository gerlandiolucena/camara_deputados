//
//  PartidosModel.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation

class PartidosModel: PaginatedObject<PartidosResult> {
    override var resultData: [Partido]? {
        didSet {
            guard let newResult = result, let deputs = resultData else { return }
            var partidos = newResult.dados
            partidos.append(contentsOf: deputs)
            result = PartidosResult(dados: partidos, links: newResult.links)
        }
    }
}
