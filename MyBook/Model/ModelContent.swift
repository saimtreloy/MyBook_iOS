//
//  ModelContent.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 21/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import Foundation

class ModelContent {
    
    var id: String?
    var name: String?
    var banner: String?
    var location: String?
    var type: String?
    var category: String?
    var date_time: String?
    
    init(id: String?, name: String?, banner: String?, location: String?, type: String?, category: String?, date_time: String?) {
        self.id = id
        self.name = name
        self.banner = banner
        self.location = location
        self.type = type
        self.category = category
        self.date_time = date_time
    }
}
