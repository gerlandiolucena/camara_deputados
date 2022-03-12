//
//  PolitiansRequest.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation

class RequestPolitians: BaseRequest<CamaraResult> {
    override var endpointUrl: String { "/v2/deputados" }
    override var query: String { "?ordem=ASC&ordenarPor=nome&itens=100" }
    
    override func replaceError() -> CamaraResult? {
        CamaraResult(dados: [], links: [])
    }
    
    func loadNextPage<Root>(to: ReferenceWritableKeyPath<Root, [Deputado]?>, on: Root, page: Int) {
        customQueries = ["pagina": "\(page)"]
        self.cancellable = publisher?.receive(on: DispatchQueue.main)
            .replaceError(with: replaceError())
            .map { $0?.dados }
            .assign(to: to, on: on)
    }
}
