const { syncDB } = require("../../tasks/sync-db");

describe("Pruebas en Syng-DB", () => {
  test("Debe de ejecutar el proceso 2 veces", () => {
    syncDB();
    const times = syncDB();
    console.log("Se llamó: ", times);
    expect(times).toBe(2);
  });
});
