//
//  PasswordErrors.swift
//  TestTaskZamZam
//
//  Created by Ацамаз Бицоев on 25/04/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

enum PasswordErrors: String {
    
    case needMoreSymbols = "Должно быть не менее 8 символов"
    case needCapitalLetter = "Необходима хотя бы одна заглавная буква"
    case differentPasswords = "Пароли не совпадают"
}
