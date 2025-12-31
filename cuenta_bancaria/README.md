# Gestión Bancaria en PowerShell

Este script permite gestionar una **cuenta bancaria virtual** mediante PowerShell. Permite registrar ingresos, gastos, movimientos entre cuentas y consultar los movimientos o el estado de la cuenta.

---

## Archivos Generados

- `cuenta_bancaria.txt`: Archivo principal donde se almacena el saldo general y las cuentas creadas.
- `movimientos.txt`: Archivo donde se registran todos los ingresos, gastos y movimientos.

---

## Funcionalidades

El script incluye las siguientes funciones:

1. **Ingreso**
   - Registrar un ingreso en la cuenta principal.
   - Actualiza el `monedero` y el `total`.
   - Guarda un registro en `movimientos.txt`.

2. **Gasto**
   - Registrar un gasto desde la cuenta principal.
   - Actualiza `monedero` y `gastos`.
   - Guarda un registro en `movimientos.txt`.

3. **Movimiento**
   - Transferir dinero entre monederos.
   - Si el monedero destino no existe, ofrece crearla automáticamente.
   - Guarda un registro en `movimientos.txt`.

4. **Ver Movimientos**
   - Muestra todos los movimientos registrados en `movimientos.txt`.

5. **Ver Cuenta Bancaria**
   - Muestra el estado actual de la cuenta principal y de todos los monederos desde `cuenta_bancaria.txt`.

---

## Requisitos

- Windows 10/11 o superior.
- PowerShell 5.1 o superior.

---

## Cómo Ejecutar el Script

1. Descarga el archivo del script (por ejemplo, `gestion_bancaria.ps1`) en tu equipo.
2. Abre **PowerShell** como administrador.
3. Navega hasta la carpeta donde está el script. Por ejemplo:

```powershell
cd C:\Ruta\Del\Script
```

4. Ejecuta el script:

```powershell
.\gestion_bancaria.ps1
```

5. Sigue el menú interactivo para elegir la opción deseada.

---

## Notas

- Al ejecutar el script por primera vez, se crea automáticamente el archivo `cuenta_bancaria.txt` con la estructura inicial.
- Todos los movimientos se registran con fecha y hora para un mejor control.
- Se recomienda mantener los archivos `cuenta_bancaria.txt` y `movimientos.txt` en la misma carpeta que el script para evitar errores de ruta.

---

## Ejemplo de Uso

```
------------------------------------
|       Menú Gestión Bancaria       |
------------------------------------
| 1. Ingreso                        |
| 2. Gasto                           |
| 3. Movimiento                      |
| 4. Ver movimientos                 |
| 5. Ver cuenta bancaria             |
| 0. Salir                           |
------------------------------------
Elige una opción:
```

Selecciona la opción deseada y sigue las instrucciones en pantalla.

---

## Autor

Este script fue creado por Carlos Chamorro, LabCCM.
