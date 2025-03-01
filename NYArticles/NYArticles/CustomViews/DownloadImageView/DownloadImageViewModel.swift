//
//  DownloadImageViewModel.swift
//  NYArticles
//
//  Created by Rajat Dhasmana on 28/02/25.
//

import Foundation
import UIKit
import Combine

class DownloadImageViewModel: ObservableObject {
    
    enum DowloadedImageActions {
        case didAppear
    }
    
    // MARK: - Published variables
    
    @Published var viewState: ViewState = .loading

    // MARK: - Private variables
    
    private var cancellables = Set<AnyCancellable>()
    private let urlStr: String
    private var imageDownloadService: DownloadImageServiceProtocol
    
    init(urlStr: String,
         imageDownloadService: DownloadImageServiceProtocol) {
        self.urlStr = urlStr
        self.imageDownloadService = imageDownloadService
    }
}

extension DownloadImageViewModel {
    func perform(action: DowloadedImageActions) {
    
        switch action {
            
        case .didAppear:
            guard let url = URL(string: urlStr) else {
                self.viewState = .failure
                return
            }
            imageDownloadService.downloadImage(url: url)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.viewState = .failure
                    }
                } receiveValue: { [weak self] img in
                    self?.viewState = .success(img)
                }
                .store(in: &cancellables)
        }
    }
}

extension DownloadImageViewModel {
    enum ViewState: Equatable {
        case loading
        case success(UIImage)
        case failure
    }
}
