//
//  ErrorCode.swift
//  Slack-App
//
//  Created by 湊航太 on 2024/09/20.
//

enum ErrorCode: Int {
    
    // 成功
    case success = 200
    
    // リダイレクト
    case movedPermanently = 301
    case found = 302

    // クライアントエラー
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case requestTimeout = 408
    case conflict = 409
    case gone = 410

    // サーバーエラー
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504

    // 独自のエラーコード
    case connectionFailed = -1009  // ネットワーク接続エラーの独自コード
    case unknown = -1              // 不明なエラー
}
