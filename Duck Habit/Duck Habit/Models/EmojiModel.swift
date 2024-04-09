//
//  EmojiModel.swift
//  Duck Habit
//
//  Created by Vita Hoang on 4/7/24.
//

import Foundation
import Smile

public struct Emoji: Hashable {

    public let value: String
    public let name: String
    public let keywords: [String]

    public init(value: String, name: String, keywords: [String]) {
        self.value = value
        self.name = name
        self.keywords = keywords
    }
}

public protocol EmojiProvider {
    func getAll() -> [Emoji]
}

public final class DefaultEmojiProvider: EmojiProvider {

    public init() { }

    public func getAll() -> [Emoji] {
        return Smile.list().map({ Emoji(value: $0, name: name(emoji: $0).first ?? "", keywords: [name(emoji: $0).first ?? ""]) })
    }

}

public final class CustomEmojiProvider: EmojiProvider {
    public init() { }
    
    public func getAll() -> [Emoji] {
        if let fileURL = Bundle.main.url(forResource: "emoji-en-US", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let emojis = try decoder.decode([String: [String]].self, from: data)
                
                // sort the keys
                let sortedKeys = emojis.keys.sorted()

                return sortedKeys.map { key in
                    Emoji(value: key, name: emojis[key]?[0] ?? "", keywords: emojis[key] ?? [])
                }
            } catch {
                print("Error reading JSON file: \(error.localizedDescription)")
            }
        } else {
            print("JSON file not found")
        }
        return DefaultEmojiProvider().getAll()
    }

}

public struct EmojiList {
    public var emojiList = CustomEmojiProvider().getAll()
}
