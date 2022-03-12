//
//  AsyncWebImageView.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation
import SwiftUI
import Combine

struct AsyncSquareWebImageView: View {
    private let url: URL
    private let placeHolder: Image
    @ObservedObject var binder = ImageLoader()
    
    init(url: URL, placeHolder: Image) {
        self.url = url
        self.placeHolder = placeHolder
    }
    
    var body: some View {
        VStack {
            if binder.image != nil {
                Image(uiImage: binder.image!)
                    .resizable()
                    .frame(maxWidth: 80, maxHeight: 80, alignment: .center)
                    .clipped()
            } else {
                placeHolder
                    .resizable()
                    .clipped()
            }
        }
        .foregroundColor(.white)
        .background(.blue)
        .onAppear { self.binder.load(url: url) }
        .onDisappear { self.binder.cancel() }
    }
}

struct AsyncSquareWebImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncSquareWebImageView(url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, placeHolder: Image(systemName: "person.fill"))
    }
}
