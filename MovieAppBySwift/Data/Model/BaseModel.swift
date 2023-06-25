//
//  BaseModel.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/23.
//

import Foundation

class BaseModel: NSObject {
    let networkAgent: MovieDBNetworkAgentProtocol = MovieDBNetworkAgent.shared
    let networking: MovieDBNetworkAgentProtocol = MovieDBNetworkAgentWithURLSession.shared
}
