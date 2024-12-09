import Foundation

struct BlogResponse: Decodable {
	let data: [BlogModel]
	let total: Int
	let countAll: Int
}

struct BlogModel: Decodable {
	let latestCommenters: [String]?
	let meta: Meta?
	let id: String?
	let slug: String
	let title: String?
	let author: String?
	let cover: String?
	let excerpt: String?
	let boardId: String?
	let createdAt: String?
	let updatedAt: String?
	let commentCount: Int?
	let type: String?
	let status: String?
	let publishTime: String?
	let labels: [String]?
	let locale: String?

}

struct Meta: Decodable {
	let unpublishedChanges: Int?
	let explicitSlug: Bool?

}
