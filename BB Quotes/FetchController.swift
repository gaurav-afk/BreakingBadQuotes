//
//  FetchController.swift
//  BB Quotes
//
//  Created by Gaurav Rawat on 2024-02-20.
//

import Foundation

struct FetchController{
    
    enum NetworkError: Error{
        case badURL, badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseURL.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true) // help us manipulate and work with URLs in a structured and correct manner
        
        // In a URL, query parameters are key-value pairs, and this sets the key part of the pair.
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus) // creating a query item that can be used to add parameters to a URL
        
        quoteComponents?.queryItems = [quoteQueryItem] // Assign the query item to the queryItems property of URLComponents
        
        
        // to check if the URL is constructed properly or not else throw error
        guard let fetchURL = quoteComponents?.url else{
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // checks if the response was successful or not
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else{ throw NetworkError.badResponse }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        var characterComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        characterComponents?.queryItems = [characterQueryItem]
        
        guard let fetchURL = characterComponents?.url else{
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else{ throw NetworkError.badResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
}


