<script>
    import GraficaCircular from "./componentes/GraficaCircular.svelte";
    import ClaseSocialTabla from "./componentes/ClaseSocialTabla.svelte";
    import GrafBarras from "./componentes/GrafBarras.svelte";

  
  let someFilter = "defaultFilter"; // Define someFilter
</script>

<main>
  <h1>Fecha del Hundimiento - 15 de Abril, 1912</h1>
  <div class="dashboard">
    <div class="contenedor-izquierda">
      <div class="grafica-circular"><GraficaCircular survivorFilter={someFilter} /></div>
      <div class="tabla"><ClaseSocialTabla /></div>
    </div>
    <div class="contenedor-derecha">
      <div class="grafica-barras"><GrafBarras /></div>
    </div>
  </div>
</main>

<style>
  :global(body) {
    background-color: #e0f7fa;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    color: #0077b6;
    user-select: none;
    
    background-image: url(../src/images/imagenFonfo.png);
    background-repeat: no-repeat;
    background-size: cover; 
    background-position: center; 
    background-attachment: fixed; 
    max-height: 100vh; 
    max-width: 100vw; 
  }

  h1 {
    text-align: center;
    color: #ffffff;
    margin-bottom: 20px;
    font-family: JetBrains Mono, monospace;
  }

  .dashboard {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 20px;
    justify-content: center;
    margin-left: 60px;
  }

  .contenedor-izquierda {
    display: flex;
    flex-direction: column;
    gap: 20px;
    align-items: center;
    justify-content: center;
    width: 100%;
    max-width: 1200px;
  }

  .contenedor-derecha{
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    max-width: 1200px;
  }

</style>
