/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author matheus
 */
public class Cliente {
   private int id;
   private String nome;
   private int idade;
   private String email;
   private String cpf;
   private String numero;
   private float credito;

    public int getId() {
        return id;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public int getIdade() {
        return idade;
    }

    public String getEmail() {
        return email;
    }

  

    public String getNumero() {
        return numero;
    }

    public float getCredito() {
        return credito;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setIdade(int idade) {
        this.idade = idade;
    }

    public void setEmail(String email) {
        this.email = email;
    }

  
    public void setNumero(String numero) {
        this.numero = numero;
    }

    public void setCredito(float credito) {
        this.credito = credito;
    }
}
