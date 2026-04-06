// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaEgipto
 * @dev Registro on-chain de la tecnologia alimentaria egipcia: Hidratacion y Lipidos.
 * Serie: Sabores de Africa (1/54)
 */
contract CulturaEgipto {

    struct Plato {
        string nombre;
        string ingredientes;     // Componentes clave del ADN del plato
        string preparacion;      // Algoritmo de ejecucion breve
        uint256 horasRemojo;     // Tecnica critica de activacion (12h, 24h, 0h)
        string tipoGrasa;        // Matriz de lipidos (Samna, Aceite, Oliva)
        bool usaDukka;           // Sello de identidad (Semillas/Especias)
        uint256 nivelShatta;     // Nivel de picante inmutable (1-5)
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;

    // El autor del contrato es el "Builder"
    address public owner;

    constructor() {
        owner = msg.sender;
        
        // Registro inicial: El Ful Medames (Pilar de la cultura)
        registrarPlato(
            "Ful Medames", 
            "Habas secas, ajo, limon, comino, aceite de oliva.",
            "Remojar habas 24h, cocer a fuego lento, machacar con limon y especias.",
            24, 
            "Aceite de Oliva y Samna", 
            true,
            2
        );
    }

    /**
     * @dev Registra una nueva ejecucion tecnica de la gastronomia egipcia.
     */
    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _remojo, 
        string memory _grasa, 
        bool _dukka,
        uint256 _shatta
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_shatta <= 5, "Escala Shatta 1-5");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            horasRemojo: _remojo,
            tipoGrasa: _grasa,
            usaDukka: _dukka,
            nivelShatta: _shatta
        });
    }

    /**
     * @dev Consulta la base tecnica de un registro especifico.
     */
    function consultarRegistro(uint256 _id) public view returns (
        string memory nombre,
        uint256 remojo,
        string memory grasa,
        bool dukka,
        uint256 shatta
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.horasRemojo, p.tipoGrasa, p.usaDukka, p.nivelShatta);
    }
}
