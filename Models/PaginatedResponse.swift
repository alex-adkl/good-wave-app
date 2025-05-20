import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let data: [T]
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalItems: Int
}