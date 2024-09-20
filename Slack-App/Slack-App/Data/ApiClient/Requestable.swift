//
//  Requestable.swift
//  Slack-App
//
//  Created by 湊航太 on 2024/09/20.
//

import Alamofire

/// APIリクエスト用プロトコル
protocol Requestable {

    typealias CompletionWithErrorCode = (ErrorCode?, ApiResponse<Response>?) -> Void

    /// レスポンスをパースする型情報
    associatedtype Response: Codable

    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var baseURL: String { get }
    var headers: HTTPHeaders { get }
    var parameters: [String: Any]? { get }

    func request(completion: @escaping CompletionWithErrorCode)
}

// MARK: - Default Implementation

extension Requestable {

    var method: HTTPMethod { return .post }
    var encoding: ParameterEncoding { return JSONEncoding.default }
    var baseURL: String { return CustomUrl.apiEndPoint }
    var headers: HTTPHeaders {
        return HTTPHeaders(["Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"])
    }
    var parameters: [String : Any]? { return nil }
}

// MARK: - Request Methods

extension Requestable {

    func request(completion: @escaping CompletionWithErrorCode) {
        AF.request(baseURL,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
        .validate()
        .responseDecodable(of: ApiResponse<Response>.self) { response in
            switch response.result {
            case .success(let model):
                print("🌟パースした型: ", String(describing: type(of: model)))
                if let data = response.data, let encoded = String(data: data, encoding: .utf8) {
                    print("データ: ", encoded)
                }
                completion(.success, model)
            case .failure(let error):
                print("リクエスト失敗: \(error.localizedDescription)")

                // ネットワークエラーの場合
                if let afError = error.asAFError, afError.isSessionTaskError {
                    completion(.connectionFailed, nil)
                    return
                }

                // HTTPステータスコードによるエラー判定
                if let statusCode = response.response?.statusCode,
                   let httpErrorCode = ErrorCode(rawValue: statusCode) {
                    completion(httpErrorCode, nil)
                } else {
                    completion(.unknown, nil)
                }
            }
        }
    }
}
