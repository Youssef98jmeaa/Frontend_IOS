//
//  ImageLoader.swift
//  YoussefMahrez
//
//  Created by Apple Esprit on 10/5/2022.
//

import Foundation
import Alamofire
import UIKit
class ImageLoader{
    
    static let shared: ImageLoader = {
        let instance = ImageLoader()
        return instance
    }()
    
    let imageCache = NSCache<NSString,UIImage>()
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    static let ANNONCE_IMAGE = "ANNONCE_IMAGE"
    static let EVENT_IMAGE = "EVENT_IMAGE"
    
    func loadImage(identifier:String,url:String,completion: @escaping (UIImage?) -> () ) {
        
        if let cachedImage = self.imageCache.object(forKey: NSString(string: identifier)) {
            completion(cachedImage)
        }else{
            utilityQueue.async {
                let url = URL(string: url)!
                
                guard let data = try? Data(contentsOf: url) else {return}
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageCache.setObject(image!, forKey: NSString(string: identifier))
                    completion (image)
                }
            }
        }
    }
}
