//
//  PoliticianDetail.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 10/03/22.
//


import Foundation
import SwiftUI

struct PoliticianDetailView: View {
    @Environment(\.presentationMode) var presentation
    var deputado: Deputado
    @ObservedObject var model = DeputadosDetailModel()
    private let network = RequestPolitianDetail()
    
    var body: some View {
        VStack {
            PoliticianPhotoView(urlFoto: deputado.urlFoto, siglaPartido: deputado.siglaPartido)
            Spacer()
            if let sectionedData = model.deputadoDetail?.dados {
                let listSections = SectionedInformationPolitians.sectionedInformationDetail(detail: sectionedData)
                List(listSections) { customSection in
                    Section(header: Text(customSection.name)) {
                        ForEach(customSection.informations) { info in
                            PoliticianDetailRow(information: info.information, detail: info.detail)
                        }
                    }
                }
            }
        }.onAppear(perform: loadPoliticianDetail)
    }
    
    func loadPoliticianDetail() {
        network.request(to: \.deputadoDetail, on: model, customPaths: ["idDeputado": "\(deputado.id)"])
    }
}

struct PoliticianPhotoView: View {
    @State var urlFoto: String
    @State var siglaPartido: String
    private let placeholder = Image(systemName: "person")
    private let placeholderFlag = Image(systemName: "flag")
    var urlPartido: String {
    return "https://www.camara.leg.br/internet/Deputado/img/partidos/\(siglaPartido).gif"
    }
    
    var body: some View {
        let url = URL(string: urlFoto)!
        let urlPartido = URL(string: urlPartido)!
        AsyncWebImageView(url: url, placeHolder: placeholder)
        .overlay(
            AsyncSquareWebImageView(url: urlPartido, placeHolder: placeholderFlag)
                    .frame(maxWidth: 40, maxHeight: 30, alignment: .trailing)
            , alignment: .bottomTrailing)
    }
}

struct PoliticianDetailRow: View {
    @State var information: String
    @State var detail: String
    
    var body: some View {
        HStack {
            Text(information)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(detail)
                .font(.system(size: 14))
        }
    }
}

struct PoliticianDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let deputado = Deputado(id: 160559,
                                nome: "ALCEU MOREIRA DA SILVA",
                                siglaPartido: "MDB",
                                siglaUf: "RS",
                                legislatura: 56,
                                uriPartido: "https://dadosabertos.camara.leg.br/api/v2/partidos/37906",
                                urlFoto: "https://www.camara.leg.br/internet/deputado/bandep/160559.jpg",
                                email: "dep.alceumoreira@camara.leg.br")
        PoliticianDetailView(deputado: deputado)
    }
}
