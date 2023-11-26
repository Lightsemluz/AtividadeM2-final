package model;

public class Livros{
private String titulo;
private int id;
private String editora;
private String autor;
private int ano;
private Float valor;

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setEditora(String editora) {
        this.editora = editora;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public void setValor(Float valor) {
        this.valor = valor;
    }

    public String getTitulo() {
        return titulo;
    }

    public int getId() {
        return id;
    }

    public String getEditora() {
        return editora;
    }

    public String getAutor() {
        return autor;
    }

    public int getAno() {
        return ano;
    }

    public Float getValor() {
        return valor;
    }

}