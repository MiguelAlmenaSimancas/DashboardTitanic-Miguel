<script>
  import { onMount } from "svelte";
  import * as d3 from "d3";

  let selectedClass = "1st";
  let classData = {
    "1st": { men: { survived: 0, deceased: 0 }, women: { survived: 0, deceased: 0 }, children: { survived: 0, deceased: 0 } },
    "2nd": { men: { survived: 0, deceased: 0 }, women: { survived: 0, deceased: 0 }, children: { survived: 0, deceased: 0 } },
    "3rd": { men: { survived: 0, deceased: 0 }, women: { survived: 0, deceased: 0 }, children: { survived: 0, deceased: 0 } },
  };

  // Función para cargar y procesar el CSV
  async function loadCSVData() {
    const data = await d3.csv("/Titanic-Dataset.csv");

    classData = {
      "1st": { men: { survived: 0, deceased: 0 }, women: { survived: 0, deceased: 0 }, children: { survived: 0, deceased: 0 } },
      "2nd": { men: { survived: 0, deceased: 0 }, women: { survived: 0, deceased: 0 }, children: { survived: 0, deceased: 0 } },
      "3rd": { men: { survived: 0, deceased: 0 }, women: { survived: 0, deceased: 0 }, children: { survived: 0, deceased: 0 } },
    };

    data.forEach(passenger => {
      const survived = +passenger.Survived;
      const pclass = passenger.Pclass.trim(); // Clase del pasajero (1, 2 o 3)
      const sex = passenger.Sex.trim().toLowerCase();
      const age = passenger.Age ? parseFloat(passenger.Age) : null;

      const classKey = pclass === "1" ? "1st" : pclass === "2" ? "2nd" : "3rd";

      let category;
      if (age !== null && age < 16) {
        category = "children";
      } else if (sex === "male") {
        category = "men";
      } else {
        category = "women";
      }

      // Actualizar los contadores
      if (survived === 1) {
        classData[classKey][category].survived++;
      } else {
        classData[classKey][category].deceased++;
      }
    });

    console.log("Datos de la tabla procesados:", classData);
  }

  // Función para actualizar la tabla al hacer clic en los botones
  function updateTable(classType) {
    selectedClass = classType;
  }

  onMount(async () => {
    await loadCSVData(); 
  });
</script>

<div class="class-table-container">
  <div class="botones">
    <button class="button-class" on:click={() => updateTable("1st")}>1ª Clase</button>
    <button class="button-class" on:click={() => updateTable("2nd")}>2ª Clase</button>
    <button class="button-class" on:click={() => updateTable("3rd")}>3ª Clase</button>
  </div>


  <table>
    <thead>
      <tr class="table-header">
        <th class="btn-border"></th>
        <th>Supervivientes</th>
        <th class="btn-border">Fallecidos</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Hombres</td>
        <td>{classData[selectedClass].men.survived}</td>
        <td>{classData[selectedClass].men.deceased}</td>
      </tr>
      <tr>
        <td>Mujeres</td>
        <td>{classData[selectedClass].women.survived}</td>
        <td>{classData[selectedClass].women.deceased}</td>
      </tr>
      <tr>
        <td>Niños</td>
        <td>{classData[selectedClass].children.survived}</td>
        <td>{classData[selectedClass].children.deceased}</td>
      </tr>
    </tbody>
  </table>
</div>

<style>
  .class-table-container {
    background-color: rgba(255, 255, 255, 0.7);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 600px;
  }
  
  .botones{
    margin-top: 1%;
    margin-bottom: 1%;
    display: flex;
    justify-content: space-between;
  }

  button {

    padding: 10px 20px;
    font-size: 16px;
    font-family: JetBrains Mono, monospace;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    background-color: #0076b67d;
    color: white;
    width: 31%;
  }

  button:hover {
    background-color: #005e8a9f;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }

  th, td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    color: #0076b6ae;
  }

  th {
    color: white;
    border-collapse: collapse;
  }


  .table-header{
    background-color: #0076b67d;
    padding: 3px;
  }
</style>
