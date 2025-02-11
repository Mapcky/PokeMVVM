//
//  ViewModelBase.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 27/01/2025.
//

import Foundation

enum LoadingState {
    case loading, success, failed, none
}


class ViewModelBase1: ObservableObject {
    @Published var loadingState: LoadingState = .none
}
