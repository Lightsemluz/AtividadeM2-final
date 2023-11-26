function deletarCli(param){
    if(param!=0 && param!=null){
        const url = "deletar_cli.jsp?cliente="+param;
        var aba = window.open(url, '_blank');
        aba.close();
        alert("cliente deletado!");
    }
    else{
        alert("ID inserido incorretamente!");
    }
}
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