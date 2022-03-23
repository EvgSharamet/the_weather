//
//  ImageLoaderService.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 22.02.2022.
//

import Foundation
import UIKit

class ImageLoaderService {
    //MARK: - data
    static let shared = ImageLoaderService()
    
    private let queue = DispatchQueue(label: "ImageLoaderService.queue",
                                      qos: .background,
                                      attributes: .concurrent)
    //MARK: - internal functions
    func resolveImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        queue.async {
            guard let url = URL(string: urlString),
                  let data = try? Data(contentsOf: url),
                  let img = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            completion(img)
        }
    }
    //MARK: - private functions
    private init() {}
}
