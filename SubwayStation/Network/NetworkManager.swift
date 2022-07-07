//
//  NetworkManager.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/07.
//

import Foundation
import Alamofire

class NetworkManager {
  
  private let apiKey = "sample"
  
  static let shared = NetworkManager()
      
  func fetchSearchData(stationName: String, completion: @escaping ([Station]) -> Void) {
        
    let urlString = "http://openapi.seoul.go.kr:8088/\(apiKey)/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
    AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
      .responseDecodable(of: StationResoponseModel.self) { response in
        guard case .success(let data) = response.result else { return }
        completion(data.stations)
      }
      .resume()
  }
  
  func fetchArrivalData(stationName: String, completion: @escaping ([StationArrivalDataResponseModel.RealTimeArrival]) -> Void) {
    
    var stationName = stationName
    if stationName.hasSuffix("역") {
      stationName.remove(at: stationName.index(before: stationName.endIndex))
    }
    let urlString = "http://swopenapi.seoul.go.kr/api/subway/\(apiKey)/json/realtimeStationArrival/0/5/\(stationName)"
    
    AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
      .responseDecodable(of: StationArrivalDataResponseModel.self) { response in
        guard case .success(let data) = response.result else { return completion([])}
        completion(data.realtimeArrivalList)
      }
      .resume()
  }
  
}
