<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Datos Personales</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            margin: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
            font-size: 7px;
        }

        th,
        td {
            border: 1px solid #000;
            padding: 5px;
            text-align: left;
            vertical-align: top;
        }

        .header-table {
            margin-bottom: 20px;
        }

        .header-table td {
            border: 1px solid #000;
            font-weight: bold;
            text-align: center;
            padding: 10px;
        }

        .logo-cell {
            width: 15%;
            text-align: center;
        }

        .title-cell {
            position: absolute;
            width: 50%;
            font-size: 11px;
            top: 50px;
        }

        .code-cell {
            width: 35%;
            font-size: 10px;
        }

        .section-header {
            /* background-color: #f0f0f0; */
            border: none;
            font-weight: bold;
            text-align: start;
            font-size: 9px;
        }

        .small-input {
            width: 40px;
            height: 8px;
            border: 1px solid #000;
            display: inline-block;
        }

        .medium-input {
            width: 80px;
            height: 8px;
            border: 1px solid #000;
            display: inline-block;
        }

        .large-input {
            width: 200px;
            height: 8px;
            border: 1px solid #000;
            display: inline-block;
        }

        .checkbox {
            width: 15px;
            height: 15px;
            border: 1px solid #000;
            display: inline-block;
        }

        .instructions {
            font-size: 10px;
            font-style: italic;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
    <!-- Encabezado -->
    <table class="header-table">
        <tr>
            <td class="logo-cell">
                <img width="40px" height="40px" src="https://res.cloudinary.com/dynpy0r4v/image/upload/v1744839553/<?= $infoEmpresa[0]["logoempresa"] ?>" alt="">
                <!-- <div style="width: 60px; height: 60px; border: 2px solid #000; border-radius: 50%; margin: 0 auto; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                    VEGA<br>PRODUCCIONES
                </div> -->
            </td>
            <td class="title-cell">
                <br>
                REGISTRO DE DATOS PERSONALES
            </td>
            <td class="code-cell">
                Negociaciones Y Producciones Vega S.A.C.<br>
                <strong>Código: RH-F-001</strong><br>
                <strong>Versión: 01</strong>
            </td>
        </tr>
    </table>

    <div class="instructions">
        <strong style="text-decoration: underline;">Indicaciones:</strong><br>
        Llenar con letra <strong>IMPRENTA y LEGIBLE</strong>
    </div>

    <!-- I. DATOS PERSONALES -->
    <table>
        <tr>
            <th class="section-header">I. DATOS PERSONALES</th>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td colspan="4" style="height: 8px;"></td>
        </tr>
        <tr>
            <th style="width: 25%; height: 5px;">APELLIDO PATERNO</th>
            <th style="width: 25%; height: 5px;">APELLIDO MATERNO</th>
            <th style="width: 50%; height: 5px;" colspan="4">NOMBRES</th>
        </tr>

    </table>

    <!-- Fecha y lugar de nacimiento -->
    <table>
        <tr>
            <th class="section-header" colspan="3">FECHA DE NACIMIENTO</th>
            <th class="section-header" colspan="4">LUGAR DE NACIMIENTO</th>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="text-align: center; width: 8%;"><strong>DÍA</strong></td>
            <td style="text-align: center; width: 8%;"><strong>MES</strong></td>
            <td style="text-align: center; width: 10%;"><strong>AÑO</strong></td>
            <td style="text-align: center; width: 20%;"><strong>DEPARTAMENTO</strong></td>
            <td style="text-align: center; width: 20%;"><strong>PROVINCIA</strong></td>
            <td style="text-align: center; width: 17%;"><strong>DISTRITO</strong></td>
            <td style="text-align: center; width: 17%;"><strong>NACIONALIDAD</strong></td>
        </tr>

    </table>

    <!-- DNI y otros datos -->
    <table>
        <tr>
            <td style="height: 8px;"></td>
            <td style="width: 8%; text-align: center; height: 8px;"><strong>F</strong></td>
            <td style="width: 8%; text-align: center; height: 8px;"><strong>M</strong></td>

            <td style="height: 8px; height: 8px;"></td>
            <td style="width: 8%; text-align: center; height: 8px;"><strong>SI</strong></td>
            <td style="width: 8%; text-align: center; height: 8px;"><strong>NO</strong></td>
        </tr>
        <tr>
            <td style="width: 15%; text-align: center; height: 8px;"><strong>DNI</strong></td>
            <td style="text-align: center; height: 8px;" colspan="2">SEXO</td>

            <td style="width: 25%; text-align: center; height: 8px;"><strong>N° R.U.C</strong></td>
            <td colspan="2" style="text-align: center; height: 8px;">DISCAPACIDAD</td>

        </tr>

    </table>

    <!-- Domicilio actual -->
    <table>
        <tr>
            <th class="section-header" colspan="4">DOMICILIO ACTUAL</th>
        </tr>
        <tr>
            <td colspan="4" style="height: 8px;"></td>
        </tr>
        <tr>
            <td colspan="4" style="height: 8px; font-size: 7px; padding-top: 2px;">
                MZ / LT/ N° - AV/JR/ CALLE – URBANIZACIÓN.
            </td>
        </tr>

    </table>

    <!-- Distrito, Provincia, etc. -->
    <table>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="width: 25%; text-align: center;"><strong>DISTRITO</strong></td>
            <td style="width: 25%; text-align: center;"><strong>PROVINCIA</strong></td>
            <td style="width: 25%; text-align: center;"><strong>DEPARTAMENTO</strong></td>
            <td style="width: 25%; text-align: center;"><strong>N°. CELULAR</strong></td>
        </tr>

    </table>

    <!-- Referencia -->
    <table>
        <tr>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <th style="text-align: center;">REFERENCIA</th>
        </tr>
    </table>

    <!-- Correo electrónico -->
    <table>
        <tr>
            <td></td>
            <td style="width: 60%; font-size: 7px; padding: 8px;">
                Autorizo que toda comunicación sea por medio del correo electrónico consignado.<br><br>
                Por lo que se dará por válidamente notificado con el envío. (COMUNICADOS Y NOTIFICACIONES)
            </td>
        </tr>
        <tr>
            <td style="width: 40%; text-align: center;"><strong>CORREO ELECTRÓNICO</strong></td>
            <td style="height: 8px;"></td>
        </tr>
    </table>

    <!-- Estado civil -->
    <table>
        <tr>
            <td colspan="1">Estado Civil </td>
            <td>Soltero</td>
        </tr>

    </table>

    <!-- Datos del cónyuge -->
    <table>
        <tr>
            <th class="section-header" colspan="4">II. DATOS DEL O LA CÓNYUGE DEL COLABORADOR</th>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="width: 25%; text-align: center;"><strong>APELLIDO PATERNO</strong></td>
            <td style="width: 25%; text-align: center;"><strong>APELLIDO MATERNO</strong></td>
            <td style="width: 35%; text-align: center;"><strong>NOMBRES</strong></td>
            <td style="width: 15%; text-align: center;"><strong>N° D.N.I</strong></td>
        </tr>
    </table>

    <!-- II. DATOS DE INSTRUCCIÓN Y FORMACIÓN GENERAL -->
    <table>
        <tr>
            <th class="section-header" colspan="5">III. DATOS DE INSTRUCCIÓN Y FORMACIÓN GENERAL</th>
        </tr>
        <tr>
            <td style="width: 20%; text-align: center;"><strong>GRADO DE INSTRUCCIÓN</strong></td>
            <td style="width: 15%; text-align: center;"><strong>CONCLUIDO</strong></td>
            <td style="width: 15%; text-align: center;"><strong>POR CONCLUIR</strong></td>
            <td style="width: 30%; text-align: center;"><strong>CENTRO DE ESTUDIOS</strong></td>
            <td style="width: 20%; text-align: center;"><strong>TÍTULO ALCANZADO</strong></td>
        </tr>
        <tr>
            <td style="text-align: center;"><strong>SECUNDARIA</strong></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="text-align: center;"><strong>TÉCNICO</strong></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="text-align: center;"><strong>UNIVERSITARIA</strong></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="text-align: center;"><strong>POST GRADO</strong></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
    </table>

    <!-- III. DATOS FAMILIARES -->
    <table>
        <tr>
            <th class="section-header" colspan="4">III. DATOS FAMILIARES</th>
        </tr>
        <tr>
            <th class="section-header" colspan="4" style="text-align: left; font-size: 7px;">DATOS DE FAMILIA DIRECTA (HIJOS Y/O PADRES)</th>
        </tr>
        <tr>
            <td style="width: 15%; text-align: center;"><strong>PARENTESCO</strong></td>
            <td style="width: 50%; text-align: center;"><strong>APELLIDOS Y NOMBRES</strong></td>
            <td style="width: 15%; text-align: center;"><strong>EDAD</strong></td>
            <td style="width: 20%; text-align: center;"><strong>N° DE D.N.I.</strong></td>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
        <tr>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
            <td style="height: 8px;"></td>
        </tr>
    </table>

    <!-- IV. DATOS FÍSICOS -->
    <table>
        <tr>
            <th class="section-header" colspan="3">IV. DATOS FÍSICOS</th>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center;"><strong>TALLAS</strong></td>
        </tr>
        <tr>
            <td style="text-align: center;"><strong>CAMISA Y/O CASACA</strong></td>
            <td style="text-align: center;"><strong>PANTALÓN</strong></td>
            <td style="text-align: center;"><strong>ZAPATOS</strong></td>
        </tr>
        <tr>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
        </tr>
    </table>

    <!-- V. INFORMACIÓN PARA PAGOS POR SERVICIOS -->
    <table>
        <tr>
            <th class="section-header">V. INFORMACIÓN PARA PAGOS POR SERVICIOS</th>
        </tr>
        <tr>
            <td style="font-size: 11px; text-align: center; padding: 10px;">
                La empresa realiza pagos mediante cuenta BCP por cuanto el colaborador debe facilitar una cuenta del mismo banco ya sea antigua o aperturar una nueva.<br>
                <strong>Número de Cuenta:</strong>
            </td>
        </tr>
        <tr>
            <td style="height: 10px;"></td>
        </tr>
    </table>

    <!-- VI. INFORMACIÓN EN CASO DE EMERGENCIAS -->
    <table>
        <tr>
            <th class="section-header" colspan="3">VI. INFORMACIÓN EN CASO DE EMERGENCIAS</th>
        </tr>
        <tr>
            <td style="width: 33%; text-align: center;"><strong>ESTATURA</strong></td>
            <td style="width: 33%; text-align: center;"><strong>PESO</strong></td>
            <td style="width: 34%; text-align: center;"><strong>GRUPO SANGUÍNEO</strong></td>
        </tr>
        <tr>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
        </tr>
    </table>

    <!-- Contacto de emergencia -->
    <table>
        <tr>
            <th colspan="3" class="section-header" style="text-align: left; font-size: 11px; padding: 8px;">
                <strong>EN CASO DE EMERGENCIA AUTORIZO QUE LA EMPRESA SE COMUNIQUE CON:</strong>
            </th>
        </tr>
        <tr>
            <td style="width: 40%; text-align: center;"><strong>APELLIDOS Y NOMBRES</strong></td>
            <td style="width: 30%; text-align: center;"><strong>PARENTESCO</strong></td>
            <td style="width: 30%; text-align: center;"><strong>TELÉFONO FIJO Y/O CELULAR</strong></td>
        </tr>
        <tr>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
        </tr>
        <tr>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
            <td style="height: 10px;"></td>
        </tr>
    </table>

    <!-- Información médica -->
    <table>
        <tr>
            <td style="width: 50%; text-align: center;"><strong>ENFERMEDADES PREEXISTENTES</strong></td>
            <td style="width: 50%; text-align: center;"><strong>ALERGIAS A MEDICAMENTOS</strong></td>
        </tr>
        <tr>
            <td style="height: 50px; vertical-align: top;"></td>
            <td style="height: 50px; vertical-align: top;"></td>
        </tr>
    </table>

    <!-- Declaración jurada -->
    <div style="margin-top: 20px; margin-bottom: 30px; font-size: 10px; text-align: justify; line-height: 1.3;">
        Asimismo, <strong>DECLARO BAJO JURAMENTO</strong> que la presente información es totalmente verdadera y se encuentra sujeta a verificación. De comprobarse fraude o falsedad en alguna información o documentación presentada, la entidad considerará no satisfecha la exigencia respectiva para todos sus efectos, sin perjuicio de las acciones que puedan iniciarse de acuerdo con el Código Penal y al Decreto Legislativo N° 728. En caso se diera cambio de la información en algún rubro, comunicaré oportunamente.
    </div>

    <!-- Firmas -->
    <table style="border: none; margin-top: 40px;">
        <tr>
            <td style="width: 25%; text-align: center; border: none; vertical-align: bottom;">
                _____________________________<br>
                <strong style="font-size: 10px;">(fecha)</strong>
            </td>
            <td style="width: 35%; text-align: center; border: none; vertical-align: bottom;">
                _____________________________________<br>
                <strong style="font-size: 10px;">(Firma del Trabajador)</strong><br>
                <strong style="font-size: 10px;">DNI N°</strong> _____________________________
            </td>
            <td style="width: 40%; text-align: center; border: none; vertical-align: bottom;">
                <div style="width: 80px; height: 100px; border: 1px solid #000; margin: 0 auto; margin-bottom: 10px;"></div>
                <strong style="font-size: 10px;">HUELLA DACTILAR</strong>
            </td>
        </tr>
    </table>
</body>

</html>