//
//  CodableBundleExtension.swift
//  Africa
//
//  Created by Fabian Kuschke on 18.08.22.
//

import Foundation
extension Bundle {
    
    func decocde(_ file: String) -> [CoverImage]{
        //1 Locate json file
        guard let url = self.url(forResource: file, withExtension: nil) else{
             fatalError("not available file \(file)")
        }
        //2 create a property for the data
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file)")
        }
        
        //3. create the decoder
        let decoder = JSONDecoder()
        
        //4. create a propety  for the decoded data
        guard let loaded = try? decoder.decode([CoverImage].self, from: data) else{
            fatalError("Failed to decode \(file)")
        }
        
        //5 return the ready to use data
        return loaded
        
    }
    
}
