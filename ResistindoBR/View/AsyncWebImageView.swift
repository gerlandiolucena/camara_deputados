//
//  AsyncWebImageView.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation
import SwiftUI
import Combine

struct AsyncWebImageView: View {
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
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(40)
                    .clipped()
            } else {
                placeHolder
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(40)
                    .clipped()
            }
        }
        .foregroundColor(.gray)
        .onAppear { self.binder.load(url: url) }
        .onDisappear { self.binder.cancel() }
    }
}

struct AsyncWebImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncWebImageView(url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, placeHolder: Image(systemName: "person.fill"))
    }
}
