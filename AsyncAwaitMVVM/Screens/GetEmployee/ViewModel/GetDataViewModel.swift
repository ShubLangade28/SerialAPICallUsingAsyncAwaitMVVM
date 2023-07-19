//
//  GetEmployeeViewModel.swift
//  AsyncAwaitMVVM
//
//  Created by PHN Tech 2 on 19/07/23.
//

import Foundation

final class GetData{
    var albums = [Albums]()
    var posts = [Posts]()
    
    var eventHandler: ((Event)->())?
    var eventHandler2: ((Event)->())?
    
    func getData(){
        Task{
            do{
                self.eventHandler?(.startLoading)
                let result = try await NetworkManager.shared.apiCall(model: [Albums].self, whichMethod: .getAlbum)
                self.eventHandler?(.stopLoading)
                switch result{
                case .success(let albums):
                    self.albums = albums
                    self.eventHandler?(.reloadData)
                    break
                case .failure(let error):
                    self.eventHandler?(.error(error))
                    break
                }
                self.eventHandler2?(.startLoading)
                let userResult = try await NetworkManager.shared.apiCall(model: [Posts].self, whichMethod: .getUsers)
                self.eventHandler2?(.stopLoading)
                switch userResult{
                case .success(let posts):
                    self.posts = posts
                    self.eventHandler2?(.reloadData)
                    break
                case .failure(let error):
                    self.eventHandler2?(.error(error))
                    break
                }
            }
             
        }
        
    }
    
}
