import { dbank } from "../../declarations/dbank";

async function checkBalance() {
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerHTML = Math.round(currentAmount * 100) / 100;
}

window.addEventListener("load", checkBalance);

document.querySelector("form").addEventListener("submit", async (e) => {
  const depositElement = document.getElementById("input-amount");
  const withdrawalElement = document.getElementById("withdrawal-amount");
  const deposit = parseFloat(depositElement.value);
  const withdrawal = parseFloat(withdrawalElement.value);

  e.preventDefault();
  
  const button = e.target.querySelector("#submit-btn");
  button.setAttribute("disabled", true);

  depositElement.value.length !== 0 && await dbank.topUp(deposit);  
  withdrawalElement.value.length !== 0 && await dbank.withdrawal(withdrawal)
  depositElement.value = withdrawalElement.value = "";

  await dbank.compound();
  checkBalance();

  button.removeAttribute("disabled");
});