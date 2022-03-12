//
//  ContentView.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import SwiftUI

struct PoliticiansList: View {
    
    @ObservedObject var model = CamaraDeputadosModel()
    @State private var showPoliticalPartyFilter = false
    @State var searchText = ""
    private let network = RequestPolitians()
    
    init() {
        refresh()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        showPoliticalPartyFilter = true
                    }, label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .frame(width: 40, height: 40, alignment: .center)
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color.blue)
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20.0)
                    })
                        .padding(.leading, 10)
                    
                    SearchBar(text: $searchText)
                }
                Spacer()
                if let results = model.result?.dados, results.count > 0 {
                    DeputadosList(deputados: results, isLoading: model.isLoading) {
                        self.loadNextPage()
                    }
                } else {
                    VStack {
                        Image(systemName: "figure.walk.diamond.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        Text("Não foram encontrados deputados do partido  \(model.partido?.sigla ?? "")")
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    Spacer()
                }
            }
            .sheet(isPresented: $showPoliticalPartyFilter, onDismiss: {
                showPoliticalPartyFilter = false
                refresh()
            }, content: {
                PoliticalPartyListView(camaraModel: model)
            })
            .navigationTitle("Deputados")
        }
    }
    
    func refresh() {
        var customQuery: [String: String]?
        if let partido = model.partido {
            customQuery = ["siglaPartido": partido.sigla]
        }
        network.request(to: \.result, on: model, customQueries: customQuery)
    }
    
    func loadNextPage() {
        model.isLoading.toggle()
        model.currentPage += 1
        network.loadNextPage(to: \.resultData, on: model, page: model.currentPage)
    }
}

struct DeputadosList: View {
    var deputados: [Deputado]
    var isLoading: Bool
    let onLastItemAppeard: () -> Void
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: items, spacing: 10) {
                ForEach(deputados, id: \.id) { deputado in
                    NavigationLink(destination: PoliticianDetailView(deputado: deputado)) {
                        DeputadoView(deputado: deputado).onAppear {
                            if deputado.id == deputados.last?.id {
                                self.onLastItemAppeard()
                            }
                        }
                    }
                }
            }
            if isLoading {
                loadingIndicator
            }
        }
        .foregroundColor(Color.gray)
    }
    
    private var loadingIndicator: some View {
        SpinnerLoading(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PoliticiansList()
    }
}
