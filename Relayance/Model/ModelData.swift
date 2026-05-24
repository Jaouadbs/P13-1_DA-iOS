//
//  ModelData.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
// Modifié pour permettre les tests unitaires (paramètre bundle)

import Foundation

struct ModelData {
    static func chargement<T: Decodable>(_ nomFichier: String, bundle: Bundle = .main) -> T {
        let data: Data

        guard let file = bundle.url(forResource: nomFichier, withExtension: nil)
        else {
            fatalError("Impossible de trouver \(nomFichier) dans le  bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Impossible de charger \(nomFichier) depuis le main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Impossible de parser \(nomFichier) en tant que \(T.self):\n\(error)")
        }
    }
}
