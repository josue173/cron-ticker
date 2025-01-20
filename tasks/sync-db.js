let times = 0;

const syncDB = () => {
  times++;
  console.log("Tick cada múltiplo de cinco ", times);
  return times;
};

module.exports = {
  syncDB,
};
