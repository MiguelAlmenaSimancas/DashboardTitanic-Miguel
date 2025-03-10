import { writable } from "svelte/store";

export const dataStore = writable({
  survival: {
    survived: 32,
    deceased: 68,
  },
  deathsByAge: {
    total: [15, 30, 50, 40, 20, 10],
    male: [10, 25, 40, 35, 15, 8],
    female: [5, 5, 10, 5, 5, 2],
  },
  classData: {
    "1st": { men: { survived: 35, deceased: 118 }, women: { survived: 90, deceased: 3 }, children: { survived: 5, deceased: 1 } },
    "2nd": { men: { survived: 25, deceased: 150 }, women: { survived: 70, deceased: 14 }, children: { survived: 10, deceased: 5 } },
    "3rd": { men: { survived: 40, deceased: 400 }, women: { survived: 80, deceased: 90 }, children: { survived: 20, deceased: 30 } },
  },
});
