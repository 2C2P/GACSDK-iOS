//
//  CryptoSwift
//
//  Copyright (C) 2014-2025 Marcin Krzyżanowski <marcin@krzyzanowskim.com>
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//  - The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
//  - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
//  - This notice may not be removed or altered from any source or binary distribution.
//

extension Array {
  @inlinable
  init(reserveCapacity: Int) {
    self = Array<Element>()
    self.reserveCapacity(reserveCapacity)
  }

  @inlinable
  var slice: ArraySlice<Element> {
    self[self.startIndex ..< self.endIndex]
  }
  
  @inlinable
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

extension Array where Element == UInt8 {
  public init(hex: String) {
    self.init(reserveCapacity: hex.unicodeScalars.lazy.underestimatedCount)
    var buffer: UInt8?
    var skip = hex.hasPrefix("0x") ? 2 : 0
    for char in hex.unicodeScalars.lazy {
      guard skip == 0 else {
        skip -= 1
        continue
      }
      guard char.value >= 48 && char.value <= 102 else {
        removeAll()
        return
      }
      let v: UInt8
      let c: UInt8 = UInt8(char.value)
      switch c {
        case let c where c <= 57:
          v = c - 48
        case let c where c >= 65 && c <= 70:
          v = c - 55
        case let c where c >= 97:
          v = c - 87
        default:
          removeAll()
          return
      }
      if let b = buffer {
        append(b << 4 | v)
        buffer = nil
      } else {
        buffer = v
      }
    }
    if let b = buffer {
      append(b)
    }
  }

  public func toHexString() -> String {
    `lazy`.reduce(into: "") {
      var s = String($1, radix: 16)
      if s.count == 1 {
        s = "0" + s
      }
      $0 += s
    }
  }
}

extension Array where Element == UInt8 {
  /// split in chunks with given chunk size
  @available(*, deprecated)
  public func chunks(size chunksize: Int) -> Array<Array<Element>> {
    var words = Array<Array<Element>>()
    words.reserveCapacity(count / chunksize)
    for idx in stride(from: chunksize, through: count, by: chunksize) {
      words.append(Array(self[idx - chunksize ..< idx])) // slow for large table
    }
    let remainder = suffix(count % chunksize)
    if !remainder.isEmpty {
      words.append(Array(remainder))
    }
    return words
  }

  public func md5() -> [Element] {
    Digest.md5(self)
  }

  public func sha1() -> [Element] {
    Digest.sha1(self)
  }

  public func sha224() -> [Element] {
    Digest.sha224(self)
  }

  public func sha256() -> [Element] {
    Digest.sha256(self)
  }

  public func sha384() -> [Element] {
    Digest.sha384(self)
  }

  public func sha512() -> [Element] {
    Digest.sha512(self)
  }

  public func sha2(_ variant: SHA2.Variant) -> [Element] {
    Digest.sha2(self, variant: variant)
  }

  public func sha3(_ variant: SHA3.Variant) -> [Element] {
    Digest.sha3(self, variant: variant)
  }

  public func crc32(seed: UInt32? = nil, reflect: Bool = true) -> UInt32 {
    Checksum.crc32(self, seed: seed, reflect: reflect)
  }

  public func crc32c(seed: UInt32? = nil, reflect: Bool = true) -> UInt32 {
    Checksum.crc32c(self, seed: seed, reflect: reflect)
  }

  public func crc16(seed: UInt16? = nil) -> UInt16 {
    Checksum.crc16(self, seed: seed)
  }

  public func encrypt(cipher: Cipher) throws -> [Element] {
    try cipher.encrypt(self.slice)
  }

  public func decrypt(cipher: Cipher) throws -> [Element] {
    try cipher.decrypt(self.slice)
  }

  public func authenticate<A: Authenticator>(with authenticator: A) throws -> [Element] {
    try authenticator.authenticate(self)
  }
}
