//
//  DeputadoView.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation
import SwiftUI

struct DeputadoView: View {
    var deputado: Deputado
    
    var body: some View {
        VStack {
            let placeholder = Image(systemName: "person")
            let url = URL(string: deputado.urlFoto)!
            AsyncWebImageView(url: url, placeHolder: placeholder)
            VStack {
                Text(deputado.nome)
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                VStack {
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10, alignment: .center)
                        Text(deputado.siglaPartido + " - " + deputado.siglaUf)
                            .font(.system(size: 12))
                            .frame(alignment: .center)
                    }
                }
            }
        }
    }
    
    
}


struct DeputadoView_Previews: PreviewProvider {
    static var previews: some View {
        let char = Deputado(
            id: 141372,
            nome: "Aelton Freitas",
            siglaPartido: "PL",
            siglaUf: "MG",
            legislatura: 56,
            uriPartido: "https://dadosabertos.camara.leg.br/api/v2/partidos/37906",
            urlFoto: "https://www.camara.leg.br/internet/deputado/bandep/141372.jpg",
            email: "dep.aeltonfreitas@camara.leg.br")
        
        DeputadoView(deputado: char)
    }
}
