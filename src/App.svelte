<script>
    import GraficaCircular from "./componentes/GraficaCircular.svelte";
    import ClaseSocialTabla from "./componentes/ClaseSocialTabla.svelte";
    import GrafBarras from "./componentes/GrafBarras.svelte";

  let someFilter = "defaultFilter"; 
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
  height: 100vh;
  width: 100vw;
  overflow: hidden; 
}

h1 {
  text-align: center;
  color: #ffffff;
  margin-bottom: 1.25rem; 
  font-family: "JetBrains Mono", monospace;
  font-size: 2rem;
}

.dashboard {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: 4%;
  gap: 1%;
  height: 90vh;
}

.contenedor-izquierda,
.contenedor-derecha {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  align-items: center;
  justify-content: center;
  width: 100%;
  max-width: 75vw;
}

/* Ajustes para móviles (menos de 768px) */
@media (max-width: 768px) {
  h1 {
    font-size: 1.5rem;
  }

  .dashboard {
    flex-direction: column;
    height: 100vh;
    gap: 1.5rem;
    padding: 1rem;
  }

  .contenedor-izquierda,
  .contenedor-derecha {
    max-width: 90vw;
    gap: 1rem;
  }


  .grafica {
    width: 90%;
    height: 180px; 
  }

  .boton {
    font-size: 0.9rem;
    padding: 0.5rem 1rem;
  }
}

@media (max-width: 480px) {
  h1 {
    font-size: 1.2rem;
  }

  .dashboard {
    gap: 1rem;
  }

  .contenedor-izquierda,
  .contenedor-derecha {
    max-width: 95vw;
    gap: 0.5rem;
  }

  .grafica {
    width: 85%;
    height: 150px;
  }

  .boton {
    font-size: 0.8rem;
    padding: 0.4rem 0.8rem;
  }
}


</style>
  
