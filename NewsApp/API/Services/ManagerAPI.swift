//
//  ManagerAPI.swift
//  lesson09
//
//  Created by Кирилл Арефьев on 04.09.2023.
//

import Foundation
import Alamofire

class ManagerAPI {
	static let shared = ManagerAPI()
	private let apiKey = "1d6f184378c849e08a94c28a6135dba6"
	
	func getURL(value: String, competion: @escaping (News) -> Void) {
		var urlComponents = URLComponents()
		
		urlComponents.scheme = "https"
		urlComponents.host = "newsapi.org"
		urlComponents.path = "/v2/everything"
		
		let parameters: Parameters = [
			"q"			:	value,
			"sortBy"	:	"popularity",
			"pageSize"	:	10,
			"language"	:	"ru",
			"apiKey"	:	apiKey
		]
		if let url = urlComponents.url {
			AF.request(url, method: .get, parameters: parameters).response { result in
				if let data = result.data {
					if let news = try? JSONDecoder().decode(News.self, from: data) {
						competion(news)
					}
				}
			}
		}
	}
	
}
