<?php require_once '../header.php' ?>

<h1>listar agenda edicion</h1>


<?php require_once '../footer.php' ?>

<script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<!-- Importar idioma español -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.js"></script>

<!-- <script>
    const idusuarioLogeado = "<?php echo $_SESSION['login']['idusuario']; ?>"
    const nivelacceso = "<?php echo $_SESSION['login']['nivelacceso']; ?>"
</script> -->

<script src="http://localhost/vega-erp/js/agenda/obtencion-agenda-nivel.js"></script> 
<script src="http://localhost/vega-erp/js/agenda/listar-agenda-edicion.js"></script> 

</body>

</html>