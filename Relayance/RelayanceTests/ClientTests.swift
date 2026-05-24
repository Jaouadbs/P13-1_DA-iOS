//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by Jaouad on 22/05/2026.
//
// RelayanceTests — Livrable 1 : Tests unitaires

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {

    // MARK: - init

    func testInit_avecDonneesValides_nomEmailEtDateSontCorrects() {
        // Given
        let nom = "Jean Martin"
        let email = "jean.martin@example.com"
        let dateString = "2023-02-20"

        // When
        let client = Client(nom: nom, email: email, dateCreationString: dateString)

        // Then
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertEqual(client.formatDateVersString(), "20-02-2023")
        XCTAssertTrue(client.dateCreation is Date)
    }

    func testInit_avecDateInvalide_dateCreationFallbackSurDateActuelle() {
        // Given
        let dateInvalide = "pas-une-date"

        // When
        let client = Client(nom: "Test", email: "test@test.com", dateCreationString: dateInvalide)

        // Then — dateFromString retourne nil → fallback Date.now → estNouveauClient() = true
        XCTAssertTrue(client.estNouveauClient())
    }

    // MARK: - creerNouveauClient

    func testCreerNouveauClient_retourneClientAvecLesBonnesInfos() {
        // Given
        let nom = "Marie Martin"
        let email = "marie.martin@example.com"

        // When
        let client = Client.creerNouveauClient(nom: nom, email: email)

        // Then
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
    }

    func testCreerNouveauClient_dateCreationEstAujourdhui() {
        // Given / When
        let client = Client.creerNouveauClient(nom: "Test", email: "test@test.com")

        // Then
        XCTAssertTrue(client.estNouveauClient())
    }

    // MARK: - estNouveauClient

    func testEstNouveauClient_clientCreeAujourdhui_retourneTrue() {
        // Given
        let client = Client.creerNouveauClient(nom: "Nouveau", email: "nouveau@test.com")

        // When / Then
        XCTAssertTrue(client.estNouveauClient())
    }

    func testEstNouveauClient_clientCreeIlYAPlusieursAns_retourneFalse() {
        // Given
        let client = Client(nom: "Ancien", email: "ancien@test.com", dateCreationString: "2020-01-01")

        // When / Then
        XCTAssertFalse(client.estNouveauClient())
    }

    // MARK: - clientExiste

    func testClientExiste_clientPresentDansLaListe_retourneTrue() {
        // Given
        let client = Client(nom: "Jean", email: "jean@test.com", dateCreationString: "2023-01-01")
        let liste = [client]

        // When / Then
        XCTAssertTrue(client.clientExiste(clientsList: liste))
    }

    func testClientExiste_clientAbsentDeLaListe_retourneFalse() {
        // Given
        let client = Client(nom: "Jean", email: "jean@test.com", dateCreationString: "2023-01-01")
        let autreClient = Client(nom: "Marie", email: "marie@test.com", dateCreationString: "2023-01-01")

        // When / Then
        XCTAssertFalse(client.clientExiste(clientsList: [autreClient]))
    }

    // MARK: - formatDateVersString

    func testFormatDateVersString_retourneFormatJJMMAAAA() {
        // Given
        let client = Client(nom: "Test", email: "test@test.com", dateCreationString: "2023-02-20")

        // When / Then
        XCTAssertEqual(client.formatDateVersString(), "20-02-2023")
    }

    func testFormatDateVersString_autreDateRetourneFormatCorrect() {
        // Given
        let client = Client(nom: "Test", email: "test@test.com", dateCreationString: "2024-12-25")

        // When / Then
        XCTAssertEqual(client.formatDateVersString(), "25-12-2024")
    }
}
