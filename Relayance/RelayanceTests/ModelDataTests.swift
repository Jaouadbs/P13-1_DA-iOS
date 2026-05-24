//
//  ModelDataTests.swift
//  RelayanceTests
//
//  Created by Jaouad on 23/05/2026.
//
// RelayanceTests — Livrable 1 : Tests unitaires
//  Sélectionner clients.json → File Inspector → cocher RelayanceTests dans Target Membership

import XCTest
@testable import Relayance

final class ModelDataTests: XCTestCase {

    func testChargement_avecFichierValide_retourneListeNonVide() {
        // Given / When
        let clients: [Client] = ModelData.chargement(
            "Source.json",
            bundle: Bundle(for: type(of: self))
        )

        // Then
        XCTAssertFalse(clients.isEmpty)
    }

    func testChargement_avecFichierValide_tousLesClientsOntNomEtEmail() {
        // Given / When
        let clients: [Client] = ModelData.chargement(
            "Source.json",
            bundle: Bundle(for: type(of: self))
        )

        // Then
        XCTAssertTrue(clients.allSatisfy { !$0.nom.isEmpty && !$0.email.isEmpty })
    }
}
