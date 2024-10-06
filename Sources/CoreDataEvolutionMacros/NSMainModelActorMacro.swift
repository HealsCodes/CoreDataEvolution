//
//  ------------------------------------------------
//  Original project: CoreDataEvolution
//  Created on 2024/9/20 by Fatbobman(东坡肘子)
//  X: @fatbobman
//  Mastodon: @fatbobman@mastodon.social
//  GitHub: @fatbobman
//  Blog: https://fatbobman.com
//  ------------------------------------------------
//  Copyright © 2024-present Fatbobman. All rights reserved.

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

/// The ModelActor in SwiftData corresponding to the Core Data version.
/// Only run in MainActor and using viewContext
/// An interface for providing mutually-exclusive access to the attributes of a conforming model.
///
///     @NSMainModelActor
///     @MainActor
///     final class DataHandler {}
///
///  will expand to
///
///     @NSModelActor
///     @MainActor
///     final class DataHandler{}
///       public let modelContainer: CoreData.NSPersistentContainer
///
///       public init(container: CoreData.NSPersistentContainer) {
///           modelContainer = container
///       }
///    extension DataHandler: CoreDataEvolution.NSModelActor {
///    }
public enum NSMainModelActorMacro {}

extension NSMainModelActorMacro: ExtensionMacro {
    public static func expansion(of _: SwiftSyntax.AttributeSyntax, attachedTo _: some SwiftSyntax.DeclGroupSyntax, providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol, conformingTo _: [SwiftSyntax.TypeSyntax], in _: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let decl: DeclSyntax =
            """
            extension \(type.trimmed): CoreDataEvolution.NSMainModelActor {}
            """

        guard let extensionDecl = decl.as(ExtensionDeclSyntax.self) else {
            return []
        }

        return [extensionDecl]
    }
}

extension NSMainModelActorMacro: MemberMacro {
    public static func expansion(of _: AttributeSyntax, providingMembersOf _: some DeclGroupSyntax, conformingTo _: [TypeSyntax], in _: some MacroExpansionContext) throws -> [DeclSyntax] {
        [
            """
            public let modelContainer: CoreData.NSPersistentContainer

            public init(container: CoreData.NSPersistentContainer) {
                modelContainer = container
            }
            """,
        ]
    }
}
