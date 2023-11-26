// Função para editar carrinho
function editarCarrinho() {
    try {
        const data = {
            id: document.getElementById("idEdit").value,
            idCliente: document.getElementById("idClienteEdit").value,
            idLivro: document.getElementById("idLivroEdit").value
        };

        const params = new URLSearchParams(data).toString();
        const urlEditarCarrinho = "editar_carrinho.jsp";
        const novaUrl = urlEditarCarrinho.includes('?') ? `${urlEditarCarrinho}&${params}` : `${urlEditarCarrinho}?${params}`;

        fetch(novaUrl, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: params,
        })
        .then(response => response.text())
        .then(() => {
            mostrarModalEditarCarrinho();
            const urlAtual = window.location.href;
            window.location.href = urlAtual;
        })
        .catch(error => {
            alert("Erro: " + error);
        });
    } catch (param) {
        alert("ERRO!" + param);
    }
}

// Função para mostrar o modal de edição do carrinho
function mostrarModalEditarCarrinho() {
    document.getElementById("editModal").classList.toggle("visible");
}

// Função para iniciar o modal de edição do carrinho
function iniciarModalEditCarrinho(id, idCliente, idLivro) {
    document.getElementById("idEdit").value = id;
    document.getElementById("idClienteEdit").value = idCliente;
    document.getElementById("idLivroEdit").value = idLivro;
    mostrarModalEditarCarrinho();
}

// Função para deletar carrinho
function deletarCarrinho(id) {
    if (id != 0 && id != null) {
        const url = "deletar_carrinho.jsp?id=" + id;
        var aba = window.open(url, '_blank');
        aba.close();
        alert("Carrinho deletado");
        const urlAtual = window.location.href;
        window.location.href = urlAtual;
    } else {
        alert("Falha no Procedimento");
    }
}
