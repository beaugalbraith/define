//
//  main.swift
//  define
//
//  Created by gamma on 11/11/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//
import Foundation
import CoreServices
import CoreServices.DictionaryServices

func main() {
  let help = "Search word in Apple's dictionary"
  let usage = "Usage: define <word>"
  var args = ProcessInfo.processInfo.arguments
  let program = args[0]
  var multiWord = ""
  switch args.count {
  case 1:
    print(usage)
    print(help)
    return
  default:
    for arg in args {
      if arg == program {
        continue
      } else {
        multiWord += "\(arg) "
      }
    }
  }
  let word = multiWord.trimmingCharacters(in: CharacterSet.whitespaces)
  let wordLength = word.lengthOfBytes(using: String.Encoding.utf8)
  let range = CFRange(location: 0, length: wordLength)
  // DCSCopyTextDefinition returns Unmanaged<CFString>? http://nshipster.com/unmanaged/
  let definition = DCSCopyTextDefinition(nil, word as CFString, range)?.takeRetainedValue()
  if let definition = definition {
    print(definition as String)
  } else {
    print("No Entries Found")
    print(usage)
  }
}
main()
