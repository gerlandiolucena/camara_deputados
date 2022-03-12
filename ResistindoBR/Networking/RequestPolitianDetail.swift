//
//  PolitiansRequest.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation

class RequestPolitianDetail: BaseRequest<DeputadoDetailResult> {
    override var endpointUrl: String { "/v2/deputados/{idDeputado}" }
    override var query: String { "" }
    
    override func replaceError() -> DeputadoDetailResult? {
        nil
    }
}
