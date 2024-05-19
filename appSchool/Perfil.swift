//
//  Perfil.swift
//  appSchool
//
//  Created by CaioCunha on 11/05/24.
//

import Foundation

struct Perfil: Codable {
    var id_user: Int
    var nome: String
    var idade: Int
    var area_trabalho: String
    var habilidades: String
    var formacao_academica: String
    var experiencia: String
    var tipo: String
}
