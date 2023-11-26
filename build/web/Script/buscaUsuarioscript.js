function editarCli () {
    try {
        const data = {id: document.getElementById("idEdit").value,
                      cpf: document.getElementById("cpfEdit").value,
                      nome: document.getElementById("nomeEdit").value,
                      email: document.getElementById("emailEdit").value,
                      numero: document.getElementById("numeroEdit").value,
                      credito: document.getElementById("creditoEdit").value
};
    const params = new URLSearchParams(data).toString();
    const urlEdit = "editar_cli.jsp";
    const novaUrl = urlEdit.includes('?') ? `${urlEdit}&${params}` : `${urlEdit}?${params}`;
    var aba = window.open(novaUrl, '_blank');
    aba.close();
    mostrarModalEditar();
    const urlAtual = window.location.href;
    window.location.href = urlAtual;
    }
    catch (param){
        alert("ERRO!"+param);
    }
}
//show EDIT
function mostrarModalEditar(){
document.getElemeSntById("editModal").classList.toggle("visible");
}
//autopreencher EDIT
function iniciarModalEdit(id,nome,email,cpf,numero,credito) {
    id: document.getElementById("idEdit").value=id;
    cpf: document.getElementById("cpfEdit").value=cpf;
    nome: document.getElementById("nomeEdit").value=nome;
    email: document.getElementById("emailEdit").value=email;
    numero: document.getElementById("numeroEdit").value=numero;
    credito: document.getElementById("creditoEdit").value=credito;
    mostrarModalEditar();
}
//DELETAR cliente
function deletarCli(param){
    if(param!=0 && param!=null){
        const url = "deletar_cli.jsp?cliente="+param;
        var aba = window.open(url, '_blank');
        aba.close();
        alert("");
        const urlAtual = window.location.href;
        window.location.href = urlAtual;
    }
    else{
        alert("Falha no Procedimento");
    }
}
//CONSULTAR cliente
function filtroCli(){
    const form = document.getElementById("filtro_cli");
    if (form.checkValidity()){
        const result = new FormData(form);
        let data = new URLSearchParams(result).toString();
        // Obtém a URL atual
    const urlAtual = window.location.href;

    // Adiciona a queryString à URL atual, verificando se já existe uma queryString na URL
    const novaURL = urlAtual.includes('?') ? `${urlAtual}&${queryString}` : `${urlAtual}?${queryString}`;

    // Redireciona para a nova URL
    window.location.href = novaURL;
    }
}