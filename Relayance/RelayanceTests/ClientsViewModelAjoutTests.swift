//
//  ClientsViewModelAjoutTests.swift
//  RelayanceTests  — Livrable 2 : Tests d'intégration — Ajout de client
//
//  Created by Jaouad on 26/05/2026.
//

import XCTest
@testable import Relayance

final class ClientsViewModelAjoutTests: XCTestCase {

    var viewModel: ClientsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ClientsViewModel(clients: [])
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - estEmailValide

    func testEstEmailValide_avecEmailCorrect_retourneTrue() {
        // Given / When / Then
        XCTAssertTrue(viewModel.estEmailValide("jean.dupont@example.com"))
    }

    func testEstEmailValide_avecEmailSansArobase_retourneFalse() {
        // Given / When / Then
        XCTAssertFalse(viewModel.estEmailValide("jeandupont.com"))
    }

    func testEstEmailValide_avecEmailSansDomaine_retourneFalse() {
        // Given / When / Then
        XCTAssertFalse(viewModel.estEmailValide("jean@"))
    }

    func testEstEmailValide_avecEmailVide_retourneFalse() {
        // Given / When / Then
        XCTAssertFalse(viewModel.estEmailValide(""))
    }

    // MARK: - ajouterClient

    func testAjouterClient_emailValide_clientEstAjouteDansLaListe() {
        // Given
        XCTAssertEqual(viewModel.clients.count, 0)

        // When
        viewModel.ajouterClient(nom: "Jean Dupont", email: "jean.dupont@example.com")

        // Then
        XCTAssertEqual(viewModel.clients.count, 1)
        XCTAssertEqual(viewModel.clients.first?.nom, "Jean Dupont")
        XCTAssertEqual(viewModel.clients.first?.email, "jean.dupont@example.com")
    }

    func testAjouterClient_emailInvalide_clientNEstPasAjoute() {
        // Given
        XCTAssertEqual(viewModel.clients.count, 0)

        // When
        viewModel.ajouterClient(nom: "Jean Dupont", email: "email-invalide")

        // Then
        XCTAssertEqual(viewModel.clients.count, 0)
    }

    func testAjouterClient_avecListeExistante_clientEstAjouteEnFin() {
        // Given
        let clientExistant = Client(nom: "Marie", email: "marie@test.com", dateCreationString: "2023-01-01")
        viewModel.ajouterClient(nom: clientExistant.nom, email: clientExistant.email)

        // When
        viewModel.ajouterClient(nom: "Jean", email: "jean@test.com")

        // Then
        XCTAssertEqual(viewModel.clients.count, 2)
        XCTAssertEqual(viewModel.clients.last?.nom, "Jean")
    }

    func testAjouterClient_nouveauClientEstNouveauClient() {
        // When
        viewModel.ajouterClient(nom: "Jean", email: "jean@test.com")

        // Then — créé aujourd'hui
        XCTAssertTrue(viewModel.clients.first?.estNouveauClient() ?? false)
    }

    func testAjouterClient_clientDoublon_nEstPasAjoute() {
        // Given
        viewModel.ajouterClient(nom: "Jean", email: "jean@test.com")
        XCTAssertEqual(viewModel.clients.count, 1)

        // When — même nom et email
        viewModel.ajouterClient(nom: "Jean", email: "jean@test.com")

        // Then
        XCTAssertEqual(viewModel.clients.count, 1)
    }

    func testClientDejaExistant_avecMajuscules_retourneTrue() {
        // Given
        viewModel.ajouterClient(nom: "Jean", email: "jean@test.com")
        XCTAssertEqual(viewModel.clients.count, 1)

        // When / Then
        XCTAssertTrue(viewModel.clientDejaExistant(nom: "JEAN", email: "JEAN@TEST.COM"))
    }
}
