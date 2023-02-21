//
//  ItemDataSource.swift
//  IncrementalSearch2023
//
//  Created by Jeremy Lua on 18/2/23.
//  Copyright © 2023 Jeremy Lua. All rights reserved.
//

import UIKit
import Combine

class ItemDataSource: NSObject {
    //For API Throttling
    static var lastAPICall = Date(timeIntervalSince1970: 0)
    
    //only one instance is required
    private static let BASE_URL = "https://api.github.com/search/repositories?"
    
    func loadList(query: String, page: Int? = nil, completion: @escaping (([Item]) -> Void), failure: @escaping (String) -> Void) -> AnyCancellable? {

        //Throttle the request to only be able make one every 5 seconds.
        //Any request made within the window will be thrown an alert pop-up
        if (Date().timeIntervalSince(Self.lastAPICall)) < 5 {
            failure("Due to API call rate limiting, the web request can only be made every 5 seconds. Please try again later")
            return nil
        }
        //Mark the last API call timing
        Self.lastAPICall = Date()

        //build the URL
        let url = buildRequestURL(query: query, page: page)
        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Result<RepositoryModel, Error> in
                // Able to decode response data properly
                if let response = try? JSONDecoder().decode(RepositoryModel.self, from: data) {
                    return .success(response)
                }
                else {
                    //Unable to decode, will throw as failure with error
                    if let httpResponse = response as? HTTPURLResponse {
                        switch (httpResponse.statusCode) {
                            case 200...299:
                                //Success yet unable to decode properly. Check the model class
                                throw URLError.init(.badServerResponse)
                            case 403:
                                throw URLError.init(URLError.Code(rawValue: 403), userInfo: ["message": "API rate limit exceeded"])
                            default:
                                break
                        }
                    }
                    return .failure(URLError.init(.unknown))
                }
            }
            .catch({ error in
                //Pass the error from the mapping
                Fail(error: error)
            })
            .sink(receiveCompletion: { completion in
                switch (completion) {
                    case .finished:
                        break
                    case .failure(let error as URLError):
                        switch error.errorCode {
                            case 403:
                                //Code=403 "API rate limit exceeded"
                                failure("API rate limit exceeded")
                            break
                            case -1002:
                                //Code=-1002 "unsupported URL"
                                failure("unsupported URL")
                                break
                            case -1009:
                                //Code=-1009 "The Internet connection appears to be offline."
                                failure("The Internet connection appears to be offline.")
                                break
                            default:
                                failure("Unknown")
                                break
                        }
                        break
                    default:
                        break
                }
            }, receiveValue: { response in
                response.map { model in
                    //Return the response back to the completion handler to update and display the data
                    completion(model.items)
                }
            })
    }
    
    func buildRequestURL(query: String, page: Int?) -> URL {
        let urlString = "\(Self.BASE_URL)" + "q=\(query)"
        
        if let page = page {
            //return the URL for the corresponding page
            return URL(string:urlString + "&page=\(page)")!
        } else {
            //return the URL for the first page of the query
            return URL(string:urlString)!
        }

    }
}
