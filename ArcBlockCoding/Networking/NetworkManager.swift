import Foundation

class NetworkManager {
	static let shared = NetworkManager()

	private init() {}

	private var defaultHeaders: [String: String] = [
		"Content-Type": "application/json",
		"User-Agent": "iOS App/1.0",
		"Accept": "application/json, text/plain, */*",
	]

	func setDefaultHeader(_ value: String, for key: String) {
		defaultHeaders[key] = value
	}

	func removeDefaultHeader(for key: String) {
		defaultHeaders.removeValue(forKey: key)
	}

	private func createRequest(url: URL, method: String, body: Data? = nil, headers: [String: String] = [:]) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = method
		request.httpBody = body

		let combinedHeaders = defaultHeaders.merging(headers) { _, custom in custom }
		for (key, value) in combinedHeaders {
			request.setValue(value, forHTTPHeaderField: key)
		}

		return request
	}

	func request<T: Decodable>(
		_ type: T.Type,
		url: URL,
		method: String = "GET",
		body: Data? = nil,
		headers: [String: String] = [:]
	) async throws -> T? {
		let request = createRequest(url: url, method: method, body: body, headers: headers)

		let (data, response) = try await URLSession.shared.data(for: request)

		if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
			throw URLError(.badServerResponse)
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		let decodedResponse = data.deCodable(type: T.self)

		return decodedResponse
	}

	func post<T: Decodable>(
		_ type: T.Type,
		url: URL,
		body: Data,
		headers: [String: String] = [:]
	) async throws -> T? {
		return try await request(type, url: url, method: "POST", body: body, headers: headers)
	}

	func get<T: Decodable>(
		_ type: T.Type,
		url: URL,
		headers: [String: String] = [:]
	) async throws -> T? {
		return try await request(type, url: url, method: "GET", headers: headers)
	}
}
