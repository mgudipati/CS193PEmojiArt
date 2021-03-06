//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import Foundation

struct EmojiArt: Codable {
  var background = Background.blank
  var emojis = [Emoji]()

  struct Emoji: Identifiable, Hashable, Codable {
    let text: String
    var x: Int // offset from the center
    var y: Int // offset from the center
    var size: Int
    let id: Int

    fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
      self.text = text
      self.x = x
      self.y = y
      self.size = size
      self.id = id
    }
  }

  init(json: Data) throws {
    self = try JSONDecoder().decode(EmojiArt.self, from: json)
  }

  init(url: URL) throws {
    let data = try Data(contentsOf: url)
    try self.init(json: data)
  }

  init() { }

  func json() throws -> Data {
    try JSONEncoder().encode(self)
  }

  private var uniqueEmojiId = 0

  mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
    uniqueEmojiId += 1
    emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
  }
}
