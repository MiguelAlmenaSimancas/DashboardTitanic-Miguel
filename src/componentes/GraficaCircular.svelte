<script>
  export let survivorFilter;
  
  let totalPassengers = 0;
  let survivors = 0;
  let deceased = 0;
  let survivorPercentage = "0";
  let deceasedPercentage = "0";

  async function loadCSVData() {
    const response = await fetch("/Titanic-Dataset.csv");
    const text = await response.text();

    const data = text.split("\n").slice(1).map(row => {
      const columns = row.split(",");
      return { Survived: parseInt(columns[1]) };
    });

    totalPassengers = data.length;
    survivors = data.filter(p => p.Survived === 1).length;
    deceased = data.filter(p => p.Survived === 0).length;
  
    survivorPercentage = ((survivors / totalPassengers) * 100).toFixed(1);
    deceasedPercentage = ((deceased / totalPassengers) * 100).toFixed(1);
  }

  // Cargar los datos al montar el componente
  import { onMount } from "svelte";
  onMount(loadCSVData);

  const handleClick = () => {
    const newMode = survivorFilter === null ? 0 : survivorFilter ? 2 : null;
    survivorFilter = newMode === 0 ? true : newMode === 2 ? false : null;
  };
</script>

<div class="survivor-indicator" role="button" tabindex="0" on:click={handleClick} on:keypress={handleClick}>
  <div class="circle {survivorFilter === null ? 'neutral' : survivorFilter ? 'survivor' : 'deceased'}">
    <p>
      {survivorFilter === null 
        ? '100%' 
        : survivorFilter 
          ? `${survivorPercentage}%` 
          : `${deceasedPercentage}%`}
    </p>
  </div>
  <p class="label">
    {survivorFilter === null
      ? `Total pasajeros: ${totalPassengers}`
      : survivorFilter
        ? `Supervivientes: ${survivors}`
        : `Fallecidos: ${deceased}`}
  </p>
</div>

<style>
  .survivor-indicator {
    background-color: rgba(255, 255, 255, 0.738);
    padding: 25px;
    border-radius: 10px;
    text-align: center;
    cursor: pointer;
    transition: box-shadow 0.3s;
    width: 600px;
    height: 250px;
    color: #0076b67d;
  }

  .survivor-indicator:hover {
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
  }

  .circle {
    width: 170px;
    height: 170px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 10px;
    border: 30px solid;
  }

  .circle.neutral {
    border-color: rgb(183, 183, 183);
  }

  .circle.survivor {
    border-color: #2196F3;  
  }

  .circle.deceased {
    border-color: #F44336; 
  }

  .label {
    margin-top: 15px;
    font-size: 1.2em;
    font-weight: bold;
  }
</style>
