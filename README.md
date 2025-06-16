# kipu-bank

El contrato inteligente presente en este repositorio, realizado en Solidity, trata sobre la interaccion con un banco. Permite a cualquier persona depositar ETH en su cuenta interna y retirarlo

#Instrucciones de despliegue

1. Abrir Remix y pegar el contenido del archivo KipuBank.sol en un nuevo archivo.
2. En "Solidity compiler" selecciona el compilador
3. En la parte de "Deploy & run transaction" en Environment selecciona Injected Provider - MetaMask, el resto lo dejas igual
4. En deploy, llena los textfield limiteDeposito y bankCap con los valores que necesites, luego preciona transact, firma el contrato y listo
5. El valor debe ingresarlo en wei, por ejemplo 500000000000000 = 0.0005

#Como interactuar con el contrato

Para interactuar con este puede ir a la pagina https://sepolia.etherscan.io/address/0x50C2D20B26D4E7F38D2e0993d7a672abA4cd9728#code 
Accedé al contrato ya desplegado.
Usá las pestañas:
- “Read Contract” para consultar datos como balances, límites y contadores.
- “Write Contract” para realizar depósitos, retiros o cualquier otra función que modifique el estado (necesitás conectar MetaMask).
Este contrato ya está desplegado y funcional.

Si desplegás tu propia versión
Luego de hacer deploy desde Remix o Hardhat, copiá la dirección de tu contrato.
Ingresá a Sepolia Etherscan.
Pegá la dirección en el buscador.
Para poder usar la pestaña “Write Contract” directamente desde Etherscan, verificá y publicá el código fuente del contrato. Esto lo hacés desde la opción “Verify and Publish”.
