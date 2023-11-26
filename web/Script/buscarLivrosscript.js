function editarLivro() {
    try {
        const data = {
            id: document.getElementById("idEdit").value,
            titulo: document.getElementById("tituloEdit").value,
            editora: document.getElementById("editoraEdit").value,
            autor: document.getElementById("autorEdit").value,
            ano: document.getElementById("anoEdit").value,
            valor: document.getElementById("valorEdit").value
        };

        const params = new URLSearchParams(data).toString();
        const urlEdit = "editar_livro.jsp";
        const novaUrl = urlEdit.includes('?') ? `${urlEdit}&${params}` : `${urlEdit}?${params}`;

        var aba = window.open(novaUrl, '_blank');
        aba.close();
        mostrarModalEditar();

        const urlAtual = window.location.href;
        window.location.href = urlAtual;
    } catch (param) {
        alert("ERRO!" + param);
    }
}

// show EDIT
function mostrarModalEditar() {
    document.getElementById("editModal").classList.toggle("visible");
}

// autopreencher EDIT
function iniciarModalEdit(id, titulo, editora, autor, ano, valor) {
    document.getElementById("idEdit").value = id;
    document.getElementById("tituloEdit").value = titulo;
    document.getElementById("editoraEdit").value = editora;
    document.getElementById("autorEdit").value = autor;
    document.getElementById("anoEdit").value = ano;
    document.getElementById("valorEdit").value = valor;
    mostrarModalEditar();
}

// DELETAR livro
function deletarLivro(param) {
    if (param != 0 && param != null) {
        const url = "deletar_livro.jsp?livro=" + param;
        var aba = window.open(url, '_blank');
        aba.close();
        alert("");
        const urlAtual = window.location.href;
        window.location.href = urlAtual;
    } else {
        alert("Falha no Procedimento");
    }
}

// CONSULTAR livro
function filtroLivro() {
    const form = document.getElementById("filtro_livros");
    if (form.checkValidity()) {
        const result = new FormData(form);
        let data = new URLSearchParams(result).toString();

        // Obtém a URL atual
        const urlAtual = window.location.href;

        // Adiciona a queryString à URL atual, verificando se já existe uma queryString na URL
        const novaURL = urlAtual.includes('?') ? `${urlAtual}&${data}` : `${urlAtual}?${data}`;

        // Redireciona para a nova URL
        window.location.href = novaURL;
    }
}
