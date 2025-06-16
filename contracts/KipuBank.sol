// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.30;

/**
 * @title KipuBank
 * @dev Permite a los usuarios depositar y retirar ETH dentro de límites establecidos.
 */
contract KipuBank {
    // =================== Variables ===================

    //tenia duda sobre como hacer esta parate del enunciado
    //"representado por una variable immutable"
    //asi que buscando, encontre que puedo escribir inmutable a las variables
    address public owner;
    uint256 public limiteDeposito;
    uint256 public bankCap;

    uint256 public depositosTotales;
    uint256 public retirosTotales;
    uint256 private currentBankBalance;

    // =============== mapping ==========================

    mapping(address => uint256) private boveda;

    // =================== Eventos ===================

    event Depositado(address indexed user, uint256 amount);
    event Retirado(address indexed user, uint256 amount);
    event EtherRecibido(address indexed from, uint256 amount, string metodo);


    // =================== Constructor ===================

    constructor(uint256 _limiteDeposito, uint256 _bankCap) {
        owner = msg.sender;
        limiteDeposito = _limiteDeposito;
        bankCap = _bankCap;
    }

    // =================== Función EXTERNAL: depósito ===================

    function depositar() external payable {
        // Errorres personalizados con revert
        if (msg.value <= 0) 
        {
            revert("Deposito invalido");
        }
        if (currentBankBalance + msg.value > bankCap){
            revert("Limite global excedido");
        }

        _ActualizarBoveda(msg.sender, msg.value);
        depositosTotales++;
        emit Depositado(msg.sender, msg.value);
    }

    // =================== Función EXTERNAL: retiro ===================

    function retirar(uint256 monto) external {
        // Errores personalizados con revert
        if (monto > limiteDeposito) {
            revert ("Excede limite retiro");
        }
        if (boveda[msg.sender] < monto) 
        {
            revert("Saldo insuficiente");
        }

        boveda[msg.sender] -= monto;
        currentBankBalance -= monto;
        retirosTotales++;

        (bool success, ) = payable(msg.sender).call{value: monto}("");
        if (!success){
            revert("Transfer failed");
        }

        emit Retirado(msg.sender, monto);
    }

    function retirarTodo() external {
        require(currentBankBalance > 0);
        uint256 miMonto = boveda[msg.sender];
        boveda[msg.sender] = 0;
        currentBankBalance -= miMonto;
        retirosTotales++;

        (bool success,) = payable(msg.sender).call{value: miMonto}("");
        if (!success){
            revert("Transfer failed");
        }

        emit Retirado(msg.sender, miMonto);

    }

    // =================== Función VIEW ===================

    function balanceOf(address user) external view returns (uint256) {
        return boveda[user];
    }

    // =================== Función PRIVATE ===================
    //Funcion que actualiza el eth de una persona
    function _ActualizarBoveda(address usuario, uint256 monto) private {
        boveda[usuario] += monto;
        currentBankBalance += monto;
    }

    // =============_ActualizarBoveda====== receive() para aceptar ETH directamente ===================

    receive() external payable {
        emit EtherRecibido(msg.sender, msg.value, "Recibido");
        depositosTotales++;
    }
}