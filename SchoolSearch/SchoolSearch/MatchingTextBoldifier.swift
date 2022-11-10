//
//  MatchingTextBoldifier.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class MatchingTextBoldifier {
    
    private var wordsArrays = [[Character]]()
    private var words = [String]()

    func resetWith(words: [String]) {
        self.words = words
        self.wordsArrays = words.map {
            Array($0)
        }
    }
    
    func attributedString(for school: UISchool) -> AttributedString {
        
        let matchingArray = matchingCharacterArray(school.school_name_char_array_lowercased)
        let markdownString = buildMarkdownString(school.school_name_char_array, matchingArray)
        
        do {
            let result = try AttributedString(markdown: markdownString)
            return result
        } catch {
            let result = AttributedString(school.school_name)
            return result
        }
        
    }
    
    private func matchingCharacterArray(_ stringArray: [Character]) -> [Bool] {
        
        var result = [Bool](repeating: false, count: stringArray.count)
        for stringIndex in stringArray.indices {
            for wordArray in wordsArrays {
                guard stringIndex + wordArray.count <= stringArray.count else {
                    continue
                }
                
                var match = true
                for wordIndex in 0..<wordArray.count {
                    if stringArray[stringIndex + wordIndex] != wordArray[wordIndex] {
                        match = false
                        break
                    }
                }
                
                if match {
                    for wordIndex in 0..<wordArray.count {
                        result[wordIndex + stringIndex] = true
                    }
                }
            }
        }
        
        return result
    }
    
    private func buildMarkdownString(_ stringArray: [Character], _ matchingArray: [Bool]) -> String {
        var markdownArray = [Character]()
        var isBold = false
        
        var index = 0
        while index < stringArray.count {
            
            if matchingArray[index] {
                if !isBold {
                    isBold = true
                    markdownArray.append("*")
                    markdownArray.append("*")
                }
                markdownArray.append(stringArray[index])
                
            } else {
                if isBold {
                    isBold = false
                    markdownArray.append("*")
                    markdownArray.append("*")
                }
                markdownArray.append(stringArray[index])
            }
            index += 1
        }
        if isBold {
            markdownArray.append("*")
            markdownArray.append("*")
        }
        return String(markdownArray)
    }
    
}
