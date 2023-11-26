/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function popupSucesso(param){
    mostraPopupSucesso();
    document.getElementById("sucesso-texto").innerHTML=param;
}
function mostraPopupSucesso(){
    const modal = document.getElementById("sucesso");
    modal.classList.toggle("modal-visibility");
}

document.getElementById("checkShow").addEventListener("change", function(){
document.getElementById("inputPackTrade").classList.toggle("input-pack-trade-show");

});
function funcaoEnviar(param){
    const produtoDisp = document.getElementById("produtoDisplay");
    const produtoVal = document.getElementById("produtoValue");
    const clienteVal = document.getElementById("cpfValue");
    if(produtoDisp != null && produtoVal != null && clienteVal.value != "" ){
        produtoDisp.innerHTML=param;
        produtoVal.value=param;
        const url = "addprod.jsp?cliente="+clienteVal.value+"&id_prod="+param;
        var aba = window.open(url, '_blank');
        aba.close();
        popupSucesso("Livro Adicionado ao Carrinho!");
    }
    else{
        alert("ID inserido incorretamente!");
    }
}


