import Foundation

// MARK: - Welcome
struct RootClass: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    let items: [Item]
    let metadata: Metadata
    let links: [CollectionLink]
}

// MARK: - Item
struct Item: Codable {
    let href: String?
    let data: [Datum]
    let links: [ItemLink]
}

// MARK: - Datum
struct Datum: Codable {
    let center: String?
    let title: String?
    let photographer: String?
    let nasaID: String?
    let date_created: String?
    let keywords: [String]?
    let mediaType: String?
    let description: String?
    let description508, secondaryCreator, location: String?
    let album: [String]?
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String?
    let rel: Rel
    let render: MediaType?
}

enum Rel: String, Codable {
    case captions = "captions"
    case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}

struct NasaInfo : Codable {
    let nasaId, nasaImage, nasaTitle, nasaDescription, nasaCenter, nasaDate, nasaPhotographer: String
}
