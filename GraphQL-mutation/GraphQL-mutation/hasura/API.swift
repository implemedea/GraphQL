// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetUserListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUserList {
      users(order_by: {id: desc}) {
        __typename
        emailid
        firstname
      }
    }
    """

  public let operationName: String = "GetUserList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("users", arguments: ["order_by": ["id": "desc"]], type: .nonNull(.list(.nonNull(.object(User.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "users": users.map { (value: User) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "users"
    public var users: [User] {
      get {
        return (resultMap["users"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["users"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("emailid", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstname", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(emailid: String, firstname: String) {
        self.init(unsafeResultMap: ["__typename": "users", "emailid": emailid, "firstname": firstname])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var emailid: String {
        get {
          return resultMap["emailid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "emailid")
        }
      }

      public var firstname: String {
        get {
          return resultMap["firstname"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstname")
        }
      }
    }
  }
}

public final class AddUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddUser($emailid: String = "", $firstname: String = "", $lastname: String = "") {
      insert_users_one(
        object: {emailid: $emailid, firstname: $firstname, lastname: $lastname}
      ) {
        __typename
        emailid
        firstname
        lastname
      }
    }
    """

  public let operationName: String = "AddUser"

  public var emailid: String?
  public var firstname: String?
  public var lastname: String?

  public init(emailid: String? = nil, firstname: String? = nil, lastname: String? = nil) {
    self.emailid = emailid
    self.firstname = firstname
    self.lastname = lastname
  }

  public var variables: GraphQLMap? {
    return ["emailid": emailid, "firstname": firstname, "lastname": lastname]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_users_one", arguments: ["object": ["emailid": GraphQLVariable("emailid"), "firstname": GraphQLVariable("firstname"), "lastname": GraphQLVariable("lastname")]], type: .object(InsertUsersOne.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertUsersOne: InsertUsersOne? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_users_one": insertUsersOne.flatMap { (value: InsertUsersOne) -> ResultMap in value.resultMap }])
    }

    /// insert a single row into the table: "users"
    public var insertUsersOne: InsertUsersOne? {
      get {
        return (resultMap["insert_users_one"] as? ResultMap).flatMap { InsertUsersOne(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_users_one")
      }
    }

    public struct InsertUsersOne: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["users"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("emailid", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstname", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastname", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(emailid: String, firstname: String, lastname: String) {
        self.init(unsafeResultMap: ["__typename": "users", "emailid": emailid, "firstname": firstname, "lastname": lastname])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var emailid: String {
        get {
          return resultMap["emailid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "emailid")
        }
      }

      public var firstname: String {
        get {
          return resultMap["firstname"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstname")
        }
      }

      public var lastname: String {
        get {
          return resultMap["lastname"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastname")
        }
      }
    }
  }
}
