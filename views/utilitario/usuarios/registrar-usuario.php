<?php require_once '../../header.php' ?>
<!-- <link rel="stylesheet" href="http://localhost/SIGEMAPRE/css/usuario-register.css"> -->

<div class="row g-0 h-100 mb-3">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header border-0 d-flex justify-content-between align-items-center">
        <h2>Registrar usuario</h2>

        <a href="<?= $host ?>views/utilitario/usuarios/listar-usuarios" class="btn btn-outline-primary btn-sm ms-auto m-0" type="button"><i class="fa-solid fa-circle-left"></i> Regresar</a>
      </div>
      <div class="card-body ">
        <h5>Datos de la Persona</h5>
        <form action="" id="form-person-user">
          <div class="row g-2 mb-4">
            <div class="col-md-4">
              <div class="input-group" style="height: 100%;">
                <input type="text"
                  style="height: 100%;"
                  autocomplete="off"
                  id="num_doc"
                  placeholder="Num Doc."
                  pattern="[0-9]*"
                  class="form-control"
                  minlength="8"
                  maxlength="20"
                  required
                  autofocus
                  title="Ingresa solo números.">
                <span class="input-group-text btn-primary" style="cursor: pointer;" id="search">
                  <i class="fa-solid fa-magnifying-glass"></i>
                </span>
              </div>
              <div class="d-flex" style="display: flex;">
                <span id="showTipoDoc" style="font-size: small; margin-left: auto; margin-right:12%"></span>
              </div>
            </div>

            <div class="col-md-3">
              <div class="form-floating">
                <input type="text" autocomplete="off" class="form-control" id="apellidos" minlength="3" required>
                <label for="apellidos" class="form-label">Apellidos</label>
              </div>
            </div>
            <div class="col-md-3">
              <div class="form-floating">
                <input type="text" autocomplete="off" class="form-control" id="nombres" required>
                <label for="nombres" class="form-label">Nombres</label>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-floating">
                <select name="genero" id="genero" class="form-select" required>
                  <option value="">Selecciona</option>
                  <option value="F">Femenino</option>
                  <option value="M">Masculino</option>
                </select>
                <label for="genero" class="form-label">Genero</label>
              </div>
            </div>
          </div>
          <div class="row g-2 mb-3 mt-1">
            <div class="col-md-4">
              <div class="form-floating">
                <input type="text" id="direccion" class="form-control" autocomplete="off">
                <label for="direccion" class="form-label">Direccion</label>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-floating">
                <input
                  type="tel"
                  autocomplete="off"
                  class="form-control"
                  id="telefono1"
                  pattern="[0-9]+"
                  maxlength="9"
                  minlength="9">
                <label for="telefono1" class="form-label">Telefono</label>
              </div>
            </div>
            <div class="col-md-2">
              <div class="form-floating">
                <input
                  type="tel"
                  autocomplete="off"
                  class="form-control"
                  id="telefono2"
                  pattern="[0-9]+"
                  maxlength="9"
                  minlength="9">
                <label for="telefono2" class="form-label">Telefono 2 (opcional)</label>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-floating">
                <input type="email" id="correo" class="form-control" autocomplete="off" placeholder="Email (Opcional)">
                <label for="correo" class="form-label">Email (Opcional)</label>
              </div>
            </div>
          </div>
          <div class="row g-2 mb-5 mt-3 form-group">
            <div class="col-md-3">
              <div class="form-floating">
                <select name="nacionalidad" id="nacionalidad" class="form-select" required">
                  <option value="">Selecciona</option>
                  <option value="31">Peru</option>
                </select>
                <label for="nacionalidad" class="form-label">Nacionalidad</label>
              </div>
            </div>
            <div class="col-md-3">
              <div class="form-floating">
                <select name="departamento" id="departamento" class="form-select" required">
                </select>
                <label for="departamento" class="form-label">Departamento</label>
              </div>
            </div>
            <div class="col-md-3">
              <div class="form-floating">
                <select name="provincia" id="provincia" class="form-select" required">
                </select>
                <label for="provincia" class="form-label">Provincia</label>
              </div>
            </div>
            <div class="col-md-3 ">
              <div class="form-floating">
                <select name="distrito" id="distrito" class="form-select" required">
                </select>
                <label for="distrito" class="form-label">Distrito</label>
              </div>
            </div>
          </div>
          <hr>
          <div class="row g-2 mb-3 mt-3 form-group">
            <h5>Datos del usuario</h5>
            <label for="nom_usuario" class="col-sm-1 form-label size-label mt-3">Nombre Usuario:</label>
            <div class="col-sm-5">
              <input type="text" id="nom_usuario" class="form-control" autocomplete="off">
            </div>
          </div>
          <div class="row g-2 mb-3 mt-3 form-group">
            <label for="claveacceso" class="col-sm-1 form-label size-label mt-3">Contraseña:</label>
            <div class="col-sm-5">
              <input type="password" id="claveacceso" class="form-control" autocomplete="off">
            </div>
          </div>
          <div class="row g-2 mt-3">
            <label for="idnivelacceso" class="col-sm-1 form-label size-label mt-3">Nivel/Rol:</label>
            <div class="col-sm-5">
              <select name="idnivelacceso" id="idnivelacceso" class="form-select filters">
                <option value="">Selecciona</option>
              </select>
            </div>
          </div>
          <div class="row g-2 mt-3 contenedor-color" hidden>
            <label for="color" class="col-sm-1 form-label size-label mt-3">Color:</label>
            <div class="col-sm-5">
              <input type="color" name="color" id="color" class="form-control">
            </div>
          </div>
          <div class="row g-2 mt-3 contenedor-porcentaje" hidden>
            <label for="porcentaje" class="col-sm-1 form-label size-label mt-3">Porcentaje (%)</label>
            <div class="col-sm-5">
              <input type="porcentaje" name="porcentaje" id="porcentaje" maxlength="3" minlength="3" class="form-control">
            </div>
          </div>

          <div class="row mt-3">
            <div class="col-sm-3">
              <button type="submit" class="form-control btn btn-primary w-75" id="btnEnviar" disabled>
                Registrar
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php require_once '../../footer.php' ?>
<script src="http://localhost/vega-erp/js/usuarios/registrar-usuario.js"></script>

</body>

</html>