//
//  SpinnerLoading.swift
//  RickAndMorty
//
//  Created by Gerlandio Lucena on 12/10/21.
//

import SwiftUI
import UIKit

struct SpinnerLoading: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
