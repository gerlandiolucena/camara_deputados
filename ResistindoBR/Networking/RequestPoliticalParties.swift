//
//  RequestPoliticalParties.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation

class RequestPoliticalParties: BaseRequest<PartidosResult> {
    override var endpointUrl: String { "/v2/partidos" }
    override var query: String { "?ordem=ASC&ordenarPor=nome&itens=40" }
    
    override func replaceError() -> PartidosResult? {
        PartidosResult(dados: [], links: [])
    }
    
    func loadNextPage<Root>(to: ReferenceWritableKeyPath<Root, [Partido]?>, on: Root, page: Int) {
        customQueries = ["pagina": "\(page)"]
        self.cancellable = publisher?.receive(on: DispatchQueue.main)
            .replaceError(with: replaceError())
            .map { $0?.dados }
            .assign(to: to, on: on)
    }
}
