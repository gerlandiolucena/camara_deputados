//
//  PoliticalPartyDetail.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 11/03/22.
//

import Foundation

class RequestPoliticalPartyDetail: BaseRequest<PoliticalPartyDetailResult> {
    override var endpointUrl: String { "/v2/partidos/{idPartido}" }
    override var query: String { "" }
    
    override func replaceError() -> PoliticalPartyDetailResult? {
        nil
    }
}
