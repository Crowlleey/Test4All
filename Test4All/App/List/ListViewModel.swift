//
//  ListViewModel.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

final class ListViewModel {
    
    let networkingState: Observable<NetworkingState> = Observable(.default)
    
    private var provider: TaskProviderProtocol!
    
    init(_ provider: TaskProviderProtocol ) {
        self.provider = provider
    }
    
    func getList() {
        networkingState.value = .loading
        provider.getList {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(_):
                self.networkingState.value = .success
            case .failure(let error):
                self.networkingState.value = .fail(error)
            }
        }
    }
}

