*** Settings ***
Documentation    Cenários de autenticação do usuário

Library      Collections
Resource    ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    
    ${user}    Create Dictionary
    ...    name=Rafael Trevisan
    ...    email=rafael@hotmail.com
    ...    password=rafa102030

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form    ${user}   
    User shoub be logged in    ${user}[name]

Não deve logar com senha inválida
    ${user}    Create Dictionary
    ...    name=Tony Stark
    ...    email=ironman@stark.com.br
    ...    password=pepper1365

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=stark123    #Biblioteca Collections = Está setando a password e alterando para informar senha inválida

    Submit login form    ${user}
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.
