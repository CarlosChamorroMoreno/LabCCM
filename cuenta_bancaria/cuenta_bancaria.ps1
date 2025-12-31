# =========================
# ARCHIVOS
# =========================
$archivoMov = "movimientos.txt"
$archivoCuenta = "cuenta_bancaria.txt"

# =========================
# FUNCIONES AUXILIARES
# =========================

function Inicializar-Cuenta {
    if (-not (Test-Path $archivoCuenta)) {
        @"
# ===============================
#   CUENTA BANCARIA VIRTUAL
# ===============================
# Última actualización: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

[SALDOS_GENERALES]
Monedero = 0
Total     = 0
Gastos    = 0

[CUENTAS]
"@ | Set-Content $archivoCuenta
    }
}


function Leer-Cuenta {
    $datos = @{}
    Get-Content $archivoCuenta | ForEach-Object {
        $p = $_ -split "="
        $datos[$p[0]] = [decimal]$p[1]
    }
    return $datos
}

function Guardar-Cuenta ($datos) {
    $datos.GetEnumerator() | ForEach-Object {
        "$($_.Key)=$($_.Value)"
    } | Set-Content $archivoCuenta
}

# =========================
# OPCIONES DEL MENÚ
# =========================

function Opcion-Ingreso {
    $nombre = Read-Host "Nombre del ingreso"
    $cantidad = [decimal](Read-Host "Cantidad (€)")
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    Add-Content $archivoMov "$fecha + ingreso + $nombre + $cantidad €"

    $cuentas = Leer-Cuenta
    $cuentas["monedero"] += $cantidad
    $cuentas["total"] += $cantidad

    Guardar-Cuenta $cuentas
    Write-Host "Ingreso registrado correctamente"
}

function Opcion-Gasto {
    $nombre = Read-Host "Nombre del gasto"
    $cantidad = [decimal](Read-Host "Cantidad (€)")
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    Add-Content $archivoMov "$fecha + gasto + $nombre + -$cantidad €"

    $cuentas = Leer-Cuenta
    $cuentas["gastos"] += $cantidad
    $cuentas["monedero"] -= $cantidad

    Guardar-Cuenta $cuentas
    Write-Host "Gasto registrado correctamente"
}

function Opcion-Movimiento {
    $origen = Read-Host "Cuenta origen"
    $destino = Read-Host "Cuenta destino"
    $cantidad = [decimal](Read-Host "Cantidad (€)")
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $cuentas = Leer-Cuenta

    if (-not $cuentas.ContainsKey($origen)) {
        Write-Host "La cuenta origen no existe"
        return
    }

    if (-not $cuentas.ContainsKey($destino)) {
        $crear = Read-Host "La cuenta destino no existe. Crear? (s/n)"
        if ($crear -eq "s") {
            $cuentas[$destino] = 0
        } else {
            return
        }
    }

    $cuentas[$origen] -= $cantidad
    $cuentas[$destino] += $cantidad

    Add-Content $archivoMov "$fecha + movimiento + $origen + $destino + $cantidad €"
    Guardar-Cuenta $cuentas

    Write-Host "Movimiento realizado correctamente"
}

function Opcion-VerMovimientos {
    Clear-Host
    Write-Host "=========== MOVIMIENTOS ===========" -ForegroundColor Cyan

    if (Test-Path $archivoMov) {
        Get-Content $archivoMov | ForEach-Object {
            Write-Host $_
        }
    } else {
        Write-Host "No hay movimientos registrados."
    }
}

function Opcion-VerCuenta {
    Clear-Host
    Write-Host "=========== ESTADO DE LA CUENTA ===========" -ForegroundColor Cyan

    if (Test-Path $archivoCuenta) {
        Get-Content $archivoCuenta | ForEach-Object {
            Write-Host $_
        }
    } else {
        Write-Host "El archivo de cuenta bancaria no existe."
    }
}



# =========================
# MENÚ PRINCIPAL
# =========================

Inicializar-Cuenta

do {
    Clear-Host
    Write-Host "------------------------------------"
    Write-Host "|       Menú Gestión Bancaria       |"
    Write-Host "------------------------------------"
    Write-Host "| 1. Ingreso                        |"
    Write-Host "| 2. Gasto                          |"
    Write-Host "| 3. Movimiento                     |"
    Write-Host "| 4. Ver movimientos                |"
    Write-Host "| 5. Ver cuenta bancaria            |"
    Write-Host "| 0. Salir                          |"
    Write-Host "------------------------------------"

    $opcion = Read-Host "Elige una opción"

    switch ($opcion) {
        "1" { Opcion-Ingreso; Pause }
        "2" { Opcion-Gasto; Pause }
        "3" { Opcion-Movimiento; Pause }
        "4" { Opcion-VerMovimientos; Pause }
        "5" { Opcion-VerCuenta; Pause }
        "0" { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida"; Pause }
    }

} while ($opcion -ne "0")
