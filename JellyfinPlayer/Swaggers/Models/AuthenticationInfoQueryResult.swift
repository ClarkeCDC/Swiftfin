//
// AuthenticationInfoQueryResult.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct AuthenticationInfoQueryResult: Codable {

    /** Gets or sets the items. */
    public var items: [AuthenticationInfo]?
    /** The total number of records available. */
    public var totalRecordCount: Int?
    /** The index of the first record in Items. */
    public var startIndex: Int?

    public init(items: [AuthenticationInfo]? = nil, totalRecordCount: Int? = nil, startIndex: Int? = nil) {
        self.items = items
        self.totalRecordCount = totalRecordCount
        self.startIndex = startIndex
    }

    public enum CodingKeys: String, CodingKey { 
        case items = "Items"
        case totalRecordCount = "TotalRecordCount"
        case startIndex = "StartIndex"
    }

}