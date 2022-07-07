//
//  StationResopnseModel.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/07.
//

import Foundation


struct StationResoponseModel: Decodable {
  
  var stations: [Station] { serchInfo.row }
  
  private let serchInfo: SeachInfoBySubwayNameServiceModel
  
  enum CodingKeys: String, CodingKey  {
    case serchInfo = "SearchInfoBySubwayNameService"
  }
  
  struct SeachInfoBySubwayNameServiceModel: Decodable {
    var row: [Station] = []
  }
}

struct Station: Decodable {
        
  let stationName: String
  let lineNumber: String
  
  enum CodingKeys: String, CodingKey {
    case stationName = "STATION_NM"
    case lineNumber = "LINE_NUM"
  }
}
