<script>
  import { onMount } from "svelte";
  import * as d3 from "d3";

  let svgContainer;
  let selectedGender = null;
  let deathsByAge = {
    male: [0, 0, 0, 0, 0, 0],
    female: [0, 0, 0, 0, 0, 0],
  };

  async function loadCSVData() {
    const data = await d3.csv("/Titanic-Dataset.csv"); // Cargar CSV desde /public

    const ageRanges = [15, 30, 45, 60, 75];

    // Reiniciar los contadores
    deathsByAge = { male: [0, 0, 0, 0, 0, 0], female: [0, 0, 0, 0, 0, 0] };

    data.forEach(passenger => {
      const survived = +passenger.Survived;
      const sex = passenger.Sex?.trim().toLowerCase();
      const age = passenger.Age ? parseFloat(passenger.Age) : null;

      if (survived === 0 && age !== null && (sex === "male" || sex === "female")) {
        const index = ageRanges.findIndex(limit => age <= limit);
        const rangeIndex = index === -1 ? 5 : index;
        deathsByAge[sex][rangeIndex]++;
      }
    });

    console.log("Datos procesados:", deathsByAge);
  }

  // Dibujar la gráfica con los datos proporcionados
  function drawChart(data, color) {
    if (!svgContainer) return;

    d3.select(svgContainer).selectAll("*").remove();

    const width = 500, height = 400;
    const svg = d3.select(svgContainer)
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(50,20)");

    const xScale = d3.scaleBand()
      .domain(["0-15", "16-30", "31-45", "46-60", "61-75", "76+"])
      .range([0, width - 100])
      .padding(0.3);

    const yScale = d3.scaleLinear()
      .domain([0, d3.max(data) || 1])
      .range([height - 50, 0]);

    svg.append("g")
      .attr("transform", `translate(0,${height - 50})`)
      .call(d3.axisBottom(xScale));

    svg.append("g").call(d3.axisLeft(yScale));

    if (selectedGender !== null) {
      svg.selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("x", (d, i) => xScale(xScale.domain()[i]))
        .attr("y", height - 50)
        .attr("width", xScale.bandwidth())
        .attr("height", 0)
        .attr("fill", color)
        .transition()
        .duration(800)
        .attr("y", d => yScale(d))
        .attr("height", d => height - 50 - yScale(d));
    }
  }

  // Función para actualizar la gráfica según el género seleccionado
  function updateChart(gender) {
    selectedGender = gender;
    drawChart(deathsByAge[gender], gender === "male" ? "#0077b6" : "#ff6f61");
  }

  onMount(async () => {
    await loadCSVData(); 
    drawChart([0, 0, 0, 0, 0, 0], "#cccccc");
  });
</script>

<div class="bar-chart-container">
  <svg bind:this={svgContainer}></svg>
  <div class="buttons">
    <button on:click={() => updateChart("male")}>Hombres</button>
    <button on:click={() => updateChart("female")}>Mujeres</button>
  </div>
</div>

<style>
  .bar-chart-container {
    background-color: rgba(255, 255, 255, 0.7);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 600px;
    text-align: center;
  }

  .buttons {
    margin-top: 15px;
  }

  button {
    margin: 5px;
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    background-color: #0076b689;
    color: white;
  }

  button:hover {
    background-color: #0076b697;
  }
</style>
