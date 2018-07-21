//
//  ModelAllBooks.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 19/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import Foundation

class ModelAllBooks {
    
    var id: String?
    var category_name: String?
    var cover: String?
    
    init(id: String?, category_name: String?, cover: String?) {
        self.id = id
        self.category_name = category_name
        self.cover = cover
    }
}
