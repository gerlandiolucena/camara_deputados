//
//  PoliticalPartyListView.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 08/03/22.
//

import Foundation
import SwiftUI

struct PoliticalPartyListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = PartidosModel()
    
    @ObservedObject var camaraModel: CamaraDeputadosModel
    private let network = RequestPoliticalParties()
    
    init(camaraModel: CamaraDeputadosModel) {
        self.camaraModel = camaraModel
        refresh()
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Fechar")
                        .padding()
                }
                Spacer()
                Button {
                    camaraModel.partido = nil
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Limpar")
                        .padding()
                }
            }

            if let results = model.result?.dados {
                List(results) { partido in
                    Text(partido.nome).onTapGesture {
                        camaraModel.partido = partido
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationTitle("Deputados")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func refresh() {
        network.request(to: \.result, on: model)
    }
    
    func loadNextPage() {
        model.isLoading.toggle()
        model.currentPage += 1
        network.loadNextPage(to: \.resultData, on: model, page: model.currentPage)
    }
}

struct PoliticalPartyListView_Preview: PreviewProvider {
    static var previews: some View {
        PoliticalPartyListView(camaraModel: CamaraDeputadosModel())
    }
}
