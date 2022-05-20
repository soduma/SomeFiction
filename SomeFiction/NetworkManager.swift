//
//  NetworkManager.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/19.
//

import Foundation
import Alamofire

class NetworkManager {
    func getMovies(searchText: String) async -> Result<NaverResponse, AFError> {
        let url = "https://openapi.naver.com/v1/search/movie.json?query=\(searchText)"
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "201FemwuZ7HTebMDK3uG",
            "X-Naver-Client-Secret": "Oqv5e6oDcp"
        ]
        
        let data = await AF.request(urlString, method: .get, headers: header)
            .serializingDecodable(NaverResponse.self).result
        return data
    }
}
