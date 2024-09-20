//
//  ApiResponse.swift
//  Slack-App
//
//  Created by 湊航太 on 2024/09/20.
//

import Foundation

/// APIのレスポンスを受け取るstruct
/// エラー発生時はdataがnilになるのでオプショナルで宣言
struct ApiResponse<T: Codable>: Codable {
    let code: Int
    let data: T?

    func success() -> Bool {
        return code == ErrorCode.success.rawValue
    }
}
