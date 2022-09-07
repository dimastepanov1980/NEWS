//
//  APICaller.swift
//  NewsApp
//
//  Created by Dmitriy Stepanov on 18.08.2022.
//

import Foundation


struct Constants {
    static let API_KEY = "127532b06a204ca8b2d874fcd4675ff7"
    static let baseURL = "https://newsapi.org/v2/"
    
}


class APICaller {
    
    static let shared = APICaller()
    
    func getTopStories(comletion: @escaping (Result<[Article], Error>) -> ()){
        guard let url = URL(string: "\(Constants.baseURL)top-headlines?country=us&apiKey=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(APIResponce.self, from: data)
                print(result.articles)
                comletion(.success(result.articles))
            } catch {
                comletion(.failure(error))
            }
        }
        task.resume()
    }
    
}
