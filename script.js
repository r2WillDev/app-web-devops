const botaoDevops = document.querySelector("#botao-devops");
const telaInicial = document.querySelector("#tela-inicial");
const telaLoading = document.querySelector("#tela-loading");
const telaResultado = document.querySelector("#tela-resultado");

botaoDevops.addEventListener("click", function () {
  telaInicial.classList.add("hidden");
  telaLoading.classList.remove("hidden");

  setTimeout(function () {
    telaLoading.classList.add("hidden");
    telaResultado.classList.remove("hidden");
  }, 3000);
});
