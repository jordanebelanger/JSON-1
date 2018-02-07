import Foundation

// MARK: - Protocols

public protocol JSONRepresentable {
    var json: JSON { get }
}

public protocol FailableJSONRepresentable {
    func json()throws -> JSON
}

// MARK: - Default Converters

extension FailableJSONRepresentable where Self: JSONRepresentable {
    public func json()throws -> JSON {
        return self.json
    }
}

extension FailableJSONRepresentable where Self: Encodable {
    public func json()throws -> JSON {
        return try (self as Encodable).json()
    }
}

extension Decodable {
    public init(json: JSON)throws {
        self = try JSONDecoder().decode(Self.self, from: json.encoded())
    }
}

extension Encodable {
    public func json()throws -> JSON {
        return try JSONDecoder().decode(JSON.self, from: JSONEncoder().encode(self))
    }
}
